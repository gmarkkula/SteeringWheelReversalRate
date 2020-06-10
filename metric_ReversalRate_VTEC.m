function SWRR = metric_ReversalRate_VTEC(SWSequence_deg, SampleRate_Hz, ...
    GapSize_deg, LowPassCutOffFreq_Hz, varargin)
%
% === Free to use and distribute, as long as this statement is included =========
% 
% (c) 2006, Gustav Markkula and Johan Engström, Volvo Technology Corporation.
% 
% This is a MATLAB implementation of the Steering Wheel Reversal Rate (SWRR) 
% metric described in: 
% 
% Markkula, G. and Engström, J. (2006). A Steering Wheel Reversal Rate 
% Metric for Assessing Effects of Visual and Cognitive Secondary Task Load. 
% Proceedings of the 13th ITS World Congress. October 8-12, 2006, London, UK. 
% (Available as of March 2020 at: http://eprints.whiterose.ac.uk/131534/)
% 
% If you use this code to support a paper or report, please cite the paper above.
% 
% ===============================================================================
% 
% This method for calculating SWRR is also standardised by SAE:
% 
% Society of Automotive Engineers (2015). Standard J2944_201506: 
% Operational definitions of driving performance measures and statistics. 
% (Available as of March 2020 at: https://www.sae.org/standards/content/j2944_201506/)
% 
% ===============================================================================
% 
% This code has been confirmed to work with MATLAB R2017a and several 
% earlier releases. If using it with filtering settings for which 
% Butterworth filter parameters have not been precalculated (see 
% GetButterworthFilter.m below), the code requires MATLAB Signal Processing 
% Toolbox to be present.
% 
% ===============================================================================
%
% 
% Usage:
%
% SWRR = metric_ReversalRate_VTEC(SWSequence_deg, SampleRate_Hz, ...
% GapSize_deg, LowPassCutOffFreq_Hz)
% Returns the number of steering wheel reversals, gap size GapSize_deg, per 
% minute in the sequence of steering wheel data SWSequence_deg, sampled in 
% degrees at a fixed sample rate SampleRate_Hz. Before counting reversals,
% signal is low pass filtered with a second order Butterworth filter with
% cut-off frequency LowPassCutOffFreq_Hz. Set to [] to omit low pass
% filtering.
%
% SWRR = metric_ReversalRate_VTEC(SWSequence_deg, SampleRate_Hz, ...
% GapSize_deg, LowPassCutOffFreq_Hz, ResampleRate_Hz, ...
% LowPassFilterOrder_nd),
% The same as above, but resamples the steering wheel angle signal to a
% (higher) sample rate ResampleRate_Hz before calculations are performed,
% and uses a Butterworth filter of order LowPassFilterOrder_nd rather than
% order two.
%
% SWRR = metric_ReversalRate_VTEC(..., 'debug')
% The same as one of the above, but also outputs some information and
% plots a visualisation of the metric calculation.
%
% SWRR = metric_ReversalRate_VTEC(..., 'niceplot')
% Does not output any information, but makes a nicer looking plot.
% 
% 
% Send any questions to Gustav Markkula.
% (E-mail address as of March 2020: g.markkula@leeds.ac.uk)
%



% get original time stamps for data
SequenceLength_s = (length(SWSequence_deg) - 1) / SampleRate_Hz;
t_orig = 0 : 1/SampleRate_Hz : SequenceLength_s;

% get default "no-resampling" resampled time stamps and data
t_resamp = t_orig;
SWSequence_deg_resamp = SWSequence_deg;

% read settings from parameters
if ismember(nargin, [4 5])
    % default settings
    LowPassFilterOrder_nd = 2;
    ResampleRate_Hz = SampleRate_Hz;
elseif ismember(nargin, [6 7])
    % user settings
    ResampleRate_Hz = varargin{1};
    LowPassFilterOrder_nd = varargin{2};
else
    error('Unexpected number of input arguments.')
end

% resample?
if ResampleRate_Hz ~= SampleRate_Hz
    if ResampleRate_Hz < SampleRate_Hz
        warning('metric_ReversalRate_VTEC:ResamplingToSlowerRate', ...
            'Resampling to slower sample rate.')
    end
    % resample
    t_resamp = 0 : 1/ResampleRate_Hz : SequenceLength_s;
    SWSequence_deg_resamp = interp1(t_orig, SWSequence_deg, t_resamp);
end

% get sw data as a column vector
SWSequence_deg_resamp = SWSequence_deg_resamp(:);

% low pass filter data?
if isempty(LowPassCutOffFreq_Hz)
    % no
    SWSequence_deg_filt = SWSequence_deg_resamp;
else
    % yes
    [B, A] = GetButterworthFilter(LowPassFilterOrder_nd, ResampleRate_Hz, LowPassCutOffFreq_Hz);
    SWSequence_deg_filt = filtfilt(B, A, SWSequence_deg_resamp);
end

% perform the metric calculation
d = [0 diff(SWSequence_deg_filt')];
extrema = find( (abs( (sign(d(1:end-1)) - sign(d(2:end))) ) == 2) | (d(1:end-1) == 0) );
upwards = FindUpwardReversals(SWSequence_deg_filt, extrema, GapSize_deg);
downwards = FindUpwardReversals(-SWSequence_deg_filt, extrema, GapSize_deg);
reversals = [upwards; downwards];
N_reversals = size(reversals, 1);
SWRR = N_reversals / SequenceLength_s * 60;



% debug
if length(find(strcmp(varargin, 'debug')))
    
    % function call info
    disp(sprintf('\n*** %s called with parameters:', mfilename))
    SampleRate_Hz
    GapSize_deg
    LowPassCutOffFreq_Hz
    LowPassFilterOrder_nd
    ResampleRate_Hz
    
    % make visualization
    clf
    subplot(2,1,1)
    hold on
    plot(t_orig, SWSequence_deg, 'x', 'LineWidth', 1, 'MarkerSize', 8)
    plot(t_resamp, SWSequence_deg_filt, 'c-', 'LineWidth', 2, 'MarkerSize', 8)
    for i = 1:size(reversals, 1)
        plot(...
            [ t_resamp(reversals(i,1)) t_resamp(reversals(i,2)) ], ...
            [ SWSequence_deg_filt(reversals(i,1)) SWSequence_deg_filt(reversals(i,2)) ], ...
            'o-k', 'MarkerSize', 10, 'LineWidth', 2)
    end
    grid on
    legend('raw data', 'filtered data', 'reversals')
    subplot(2, 1, 2)
    hold on
    plot(t_resamp, d, '.', 'MarkerSize', 5)
    plot(t_resamp(extrema), d(extrema), 'ok', 'LineWidth', 2)
    grid on
    legend ('derivative (\theta´)', 'stationary points')

elseif length(find(strcmp(varargin, 'niceplot')))
    
    % make a nice looking plot
    clf
    set(gca, 'FontSize', 22)
    hold on
    plot(t_orig, SWSequence_deg, 'k+', 'LineWidth', 1, 'MarkerSize', 10)
    plot(t_resamp, SWSequence_deg_filt, 'k-', 'LineWidth', 1, 'MarkerSize', 15)
    for i = 1:size(reversals, 1)
        plot(...
            [ t_resamp(reversals(i,1)) t_resamp(reversals(i,2)) ], ...
            [ SWSequence_deg_filt(reversals(i,1)) SWSequence_deg_filt(reversals(i,2)) ], ...
            'o-k', 'MarkerSize', 15, 'LineWidth', 2)
    end
    grid on
    xlabel('Time (s)')
    ylabel('Steering wheel angle (degrees)')
    legend('Raw steering wheel angle data', 'Filtered steering wheel signal', 'Reversals', ...
        'Location', 'Best')

end



% helper function for finding "upwards" reversals
function UpwardReversals = ...
    FindUpwardReversals(SteerAngle_deg, Extrema, GapSize_deg)

N_extrema = length(Extrema);
i = 1;
UpwardReversals = [];
for j = 1:N_extrema
    if SteerAngle_deg(Extrema(j)) - SteerAngle_deg(Extrema(i)) > GapSize_deg
        UpwardReversals = [UpwardReversals; Extrema(i) Extrema(j)];
        i = j;
    elseif SteerAngle_deg(Extrema(j)) <= SteerAngle_deg(Extrema(i))
        i = j;
    end
end
        

