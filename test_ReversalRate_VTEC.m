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
% 
% 
% This script is an example showing how to use the metric implementation. 
% It uses the filter settings and gap sizes recommended in the Markkula and 
% Engström (2006) paper to compare one example baseline driving recording 
% with two example recordings of visually and cognitively distracted driving, 
% respectively. Just type test_ReversalRate_VTEC in MATLAB to run it.
%

clearvars
close all

% load some test data
load TestSequences



% baseline recording - analysed as recommended for testing for visual
% distraction effects
figure(1)
set(gcf, 'Name', 'Baseline driving - analysed for large steering reversals')
GapSize_deg = 3;
LowPassCutOffFreq_Hz = 0.6;
SWRR = metric_ReversalRate_VTEC(TestSequence_CurvedRoadBaseline_deg, ...
    SampleRate_Hz, GapSize_deg, LowPassCutOffFreq_Hz, 'debug');
subplot(2,1,1)
title('Curved road segment, baseline driving, fLP = 0.6 Hz, gap size 3 degrees')
subplot(2,1,2)
title(sprintf('Obtained reversal rate: %.1f reversals / minute', SWRR))

% visual distraction recording - analysed as recommended for testing for 
% visual distraction effects
figure(2)
set(gcf, 'Name', 'Visually distracted driving - analysed for large steering reversals')
SWRR = metric_ReversalRate_VTEC(TestSequence_CurvedRoadVisualTask_deg, ...
    SampleRate_Hz, GapSize_deg, LowPassCutOffFreq_Hz, 'debug');
subplot(2,1,1)
title('Curved road segment, visual task driving, fLP = 0.6 Hz, gap size 3 degrees')
subplot(2,1,2)
title(sprintf('Obtained reversal rate: %.1f reversals / minute', SWRR))



% baseline recording - analysed as recommended for testing for cognitive
% distraction effects
figure(3)
set(gcf, 'Name', 'Baseline driving - analysed for small steering reversals')
GapSize_deg = 0.1;
LowPassCutOffFreq_Hz = 2;
SWRR = metric_ReversalRate_VTEC(TestSequence_CurvedRoadBaseline_deg, ...
    SampleRate_Hz, GapSize_deg, LowPassCutOffFreq_Hz, 'debug');
subplot(2,1,1)
title('Curved road segment, baseline driving, fLP = 2 Hz, gap size 0.1 degrees')
subplot(2,1,2)
title(sprintf('Obtained reversal rate: %.1f reversals / minute', SWRR))

% cognitive distraction recording - analysed as recommended for testing for 
% cognitive distraction effects
figure(4)
set(gcf, 'Name', 'Cognitively distracted driving - analysed for small steering reversals')
SWRR = metric_ReversalRate_VTEC(TestSequence_CurvedRoadCognitiveTask_deg, ...
    SampleRate_Hz, GapSize_deg, LowPassCutOffFreq_Hz, 'debug');
subplot(2,1,1)
title('Curved road segment, cognitive task driving, fLP = 2 Hz, gap size 0.1 degrees')
subplot(2,1,2)
title(sprintf('Obtained reversal rate: %.1f reversals / minute', SWRR))







