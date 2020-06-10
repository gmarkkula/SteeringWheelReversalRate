function [FiltNum, FiltDen] = GetButterworthFilter(N, SampleRate, Cutoff, ArgStr)
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
% [FiltNum, FiltDen] = GetButterworthFilter(N, SampleRate_Hz, CutoffFreq_Hz)
% Returns Butterworth low pass filter coefficients of order N with cutoff
% frequency CutoffFreg_Hz, given the sample rate SampleRate_Hz. Some
% filters are precalculated in this function, and if asked for the
% parameters of a filter that is not precalculated a warning will be
% given. The main purpose of this function is to give access to
% precalculated filter parameters, as a quicker alternative to using the
% MATLAB function 'butter' repeatedly. To disable the warning, use: 
%
% warning('off', 'GetButterworthFilter:FilterParamsNotPrecalculated') 
%
%
% [FiltNum, FiltDen] = GetButterworthFilter(N, SampleRate_Hz, CutoffFreq_Hz, 'high')
% Returns high pass filter.
% 
% 
% Send any questions to Gustav Markkula.
% (E-mail address as of March 2020: g.markkula@leeds.ac.uk)
%

ErrStr = [];
Warn = false;

Wn = Cutoff / (SampleRate / 2);

if nargin == 4
    if strcmp(ArgStr, 'high')
        
        if (N == 2 & abs(Wn - 0.00666666666667) < 0.00000000000001)
            % Wn for e.g. SampleRate=30 and Cutoff=0.1
            FiltNum = [0.98529950726865  -1.97059901453729   0.98529950726865];
            FiltDen = [1.00000000000000  -1.97038289837420   0.97081513070039];
        elseif (N == 2 & abs(Wn - 0.013333333333333) < 0.00000000000001)
            % Wn for e.g. SampleRate=30 and Cutoff=0.2
            FiltNum = [0.97081503932272  -1.94163007864545   0.97081503932272];
            FiltDen = [1.00000000000000  -1.94077813526383   0.94248202202707];
        elseif (N == 2 & Wn == 0.02)
            % Wn for e.g. SampleRate=30 and Cutoff=0.3
            FiltNum = [0.95654322555688  -1.91308645111375   0.95654322555688];
            FiltDen = [1.00000000000000  -1.91119706742607   0.91497583480143];
        elseif (N == 2 & abs(Wn - 0.02666666666667) < 0.00000000000001)
            % Wn for e.g. SampleRate=30 and Cutoff=0.4
            FiltNum = [0.94248063243344  -1.88496126486687   0.94248063243344];
            FiltDen = [1.00000000000000  -1.88165004617932   0.88827248355443];
        elseif (N == 2 & abs(Wn - 0.03333333333333) < 0.00000000000001)
            % Wn for e.g. SampleRate=30 and Cutoff=0.5
            FiltNum = [0.92862377785650  -1.85724755571301   0.92862377785650];
            FiltDen = [1.00000000000000  -1.85214648539594   0.86234862603008];
        elseif (N == 2 & Wn == 0.05)
            % Wn for e.g. SampleRate=30 and Cutoff=0.75
            FiltNum = [0.89485860612257  -1.78971721224515   0.89485860612257];
            FiltDen = [1.00000000000000  -1.77863177782459   0.80080264666571];
        elseif (N == 2 & abs(Wn - 0.06666666666667) < 0.00000000000001)
            % Wn for e.g. SampleRate=30 and Cutoff=1
            FiltNum = [0.86230183514824  -1.72460367029647   0.86230183514824];
            FiltDen = [1.00000000000000  -1.70555214554408   0.74365519504887];
        elseif (N == 2 & Wn == 0.1)
            % Wn for e.g. SampleRate=30 and Cutoff=1.5
            FiltNum = [0.80059240346457  -1.60118480692914   0.80059240346457];
            FiltDen = [1.00000000000000  -1.56101807580072   0.64135153805756];
        elseif (N == 2 & abs(Wn - 0.13333333333333) < 0.00000000000001)
            % Wn for e.g. SampleRate=30 and Cutoff=2
            FiltNum = [0.74306313547670  -1.48612627095340   0.74306313547670];
            FiltDen = [1.00000000000000  -1.41898265221812   0.55326988968868];
        elseif (N == 2 & Wn == 0.2)
            % Wn for e.g. SampleRate=30 and Cutoff=3
            FiltNum = [0.63894552515902  -1.27789105031804   0.63894552515902];
            FiltDen = [1.00000000000000  -1.14298050253990   0.41280159809619];
        elseif (N == 2 & abs(Wn - 0.26666666666667) < 0.00000000000001)
            % Wn for e.g. SampleRate=30 and Cutoff=4
            FiltNum = [0.54708275504392  -1.09416551008785   0.54708275504392];
            FiltDen = [1.00000000000000  -0.87727063230739   0.31106038786830];
        elseif (N == 2 & abs(Wn - 0.33333333333333) < 0.00000000000001)
            % Wn for e.g. SampleRate=30 and Cutoff=5
            FiltNum = [0.46515307716505  -0.93030615433009   0.46515307716505];
            FiltDen = [1.00000000000000  -0.62020410288673   0.24040820577346];
        elseif (N == 2 & Wn == 0.4)
            % Wn for e.g. SampleRate=30 and Cutoff=6
            FiltNum = [0.39133577250177  -0.78267154500354   0.39133577250177];
            FiltDen = [1.00000000000000  -0.36952737735124   0.19581571265583];
        elseif (N == 2 & abs(Wn - 0.46666666666667) < 0.00000000000001)
            % Wn for e.g. SampleRate=30 and Cutoff=7
            FiltNum = [0.32424464209219  -0.64848928418438   0.32424464209219];
            FiltDen = [1.00000000000000  -0.12274122501252   0.17423734335624];
        elseif (N == 2 & abs(Wn - 0.53333333333333) < 0.00000000000001)
            % Wn for e.g. SampleRate=30 and Cutoff=8
            FiltNum = [0.26287402958593  -0.52574805917186   0.26287402958593];
            FiltDen = [1.00000000000000   0.12274122501252   0.17423734335624];
        elseif (N == 2 & Wn == 0.6)
            % Wn for e.g. SampleRate=30 and Cutoff=9
            FiltNum = [0.20657208382615  -0.41314416765230   0.20657208382615];
            FiltDen = [1.00000000000000   0.36952737735124   0.19581571265583];
        elseif (N == 2 & abs(Wn - 0.66666666666667) < 0.00000000000001)
            % Wn for e.g. SampleRate=30 and Cutoff=10
            FiltNum = [0.15505102572168  -0.31010205144336   0.15505102572168];
            FiltDen = [1.00000000000000   0.62020410288673   0.24040820577346];
            
        elseif (N == 5 & abs(Wn - 0.00666666666667) < 0.00000000000001)
            % Wn for e.g. SampleRate=30 and Cutoff=0.1
            FiltNum = [0.96667900280939  -4.83339501404696   9.66679002809393  -9.66679002809393   4.83339501404696  -0.96667900280939];
            FiltDen = [1.00000000000000  -4.93222431218111   9.73118834313281  -9.60017143634846   4.73567570376564  -0.93446829447256];
         elseif (N == 5 & Wn == 0.02)
            % Wn for e.g. SampleRate=30 and Cutoff=0.3
            FiltNum = [0.90331427533516  -4.51657137667578   9.03314275335156  -9.03314275335156   4.51657137667578  -0.90331427533516];
            FiltDen = [1.00000000000000  -4.79668159981781   9.20724237509201  -8.84036968250099   4.24578647328992  -0.81597668002428];
        elseif (N == 5 & abs(Wn - 0.03333333333333) < 0.00000000000001)
            % Wn for e.g. SampleRate=30 and Cutoff=0.5
            FiltNum = [0.84405644567686  -4.22028222838428   8.44056445676855  -8.44056445676855   4.22028222838428  -0.84405644567686];
            FiltDen = [1.00000000000000  -4.66116478333266   8.70135524421047  -8.13130172488138   3.80355322574633  -0.71243128348854];
        elseif (N == 5 & abs(Wn - 0.06666666666667) < 0.00000000000001)
            % Wn for e.g. SampleRate=30 and Cutoff=1
            FiltNum = [0.71202048199027  -3.56010240995137   7.12020481990274  -7.12020481990274   3.56010240995137  -0.71202048199027];
            FiltDen = [1.00000000000000  -4.32259612675314   7.51418241128532  -6.56261229709248   2.87829142186758  -0.50697316669026];
        elseif (N == 5 & abs(Wn - 0.13333333333333) < 0.00000000000001)
            % Wn for e.g. SampleRate=30 and Cutoff=2
            FiltNum = [0.50460757619954  -2.52303788099768   5.04607576199537  -5.04607576199537   2.52303788099768  -0.50460757619954];
            FiltDen = [1.00000000000000  -3.64722245584034   5.45962345438380  -4.16836695537251   1.61760081476554  -0.25462875802298];
        elseif (N == 5 & Wn == 0.2)
            % Wn for e.g. SampleRate=30 and Cutoff=3
            FiltNum = [0.35416418109343  -1.77082090546715   3.54164181093430  -3.54164181093430   1.77082090546715  -0.35416418109343];
            FiltDen = [1.00000000000000  -2.97542210974568   3.80601811932041  -2.54525286833047   0.88113007543784  -0.12543062215536];
        elseif (N == 5 & abs(Wn - 0.26666666666667) < 0.00000000000001)
            % Wn for e.g. SampleRate=30 and Cutoff=4
            FiltNum = [0.24476787171461  -1.22383935857307   2.44767871714614  -2.44767871714614   1.22383935857307  -0.24476787171461];
            FiltDen = [1.00000000000000  -2.30797359412991   2.52373656071397  -1.47990368259606   0.46106508390698  -0.05989297352073];
        elseif (N == 5 & abs(Wn - 0.33333333333333) < 0.00000000000001)
            % Wn for e.g. SampleRate=30 and Cutoff=5
            FiltNum = [0.16542335572437  -0.82711677862186   1.65423355724373  -1.65423355724373   0.82711677862186  -0.16542335572437];
            FiltDen = [1.00000000000000  -1.64484891141637   1.58661518294383  -0.80488189477624   0.22994912012653  -0.02725227391698];
        elseif (N == 5 & Wn == 0.4)
            % Wn for e.g. SampleRate=30 and Cutoff=6
            FiltNum = [0.10837370258748  -0.54186851293740   1.08373702587480  -1.08373702587480   0.54186851293740  -0.10837370258748];
            FiltDen = [1.00000000000000  -0.98532523927924   0.97384933183676  -0.38635655864845   0.11116384057834  -0.01126351245657];
        elseif (N == 5 & abs(Wn - 0.46666666666667) < 0.00000000000001)
            % Wn for e.g. SampleRate=30 and Cutoff=7
            FiltNum = [0.06802792533064  -0.34013962665319   0.68027925330637  -0.68027925330637   0.34013962665319  -0.06802792533064];
            FiltDen = [1.00000000000000  -0.32816749900665   0.67110782133673  -0.11311142936997   0.06149993462651  -0.00300692624053];
        elseif (N == 5 & abs(Wn - 0.53333333333333) < 0.00000000000001)
            % Wn for e.g. SampleRate=30 and Cutoff=8
            FiltNum = [0.04026005941707  -0.20130029708533   0.40260059417065  -0.40260059417065   0.20130029708533  -0.04026005941707];
            FiltDen = [1.00000000000000   0.32816749900664   0.67110782133673   0.11311142936997   0.06149993462651   0.00300692624053];
            
        else
            Warn = true;
            [FiltNum FiltDen] = butter(N, Wn, 'high');
        end
        
    else
        ErrStr = sprintf('Unexpected value "%s" for input parameter ArgStr.', ArgStr);
    end
    
elseif nargin == 3
    
    if (N == 2 & Wn == 0.04)
        % Wn for e.g. SampleRate=30 and Cutoff=0.6
        FiltNum = [0.00362168151493   0.00724336302986   0.00362168151493];
        FiltDen = [1.00000000000000  -1.82269492519631   0.83718165125602];
    elseif (N == 2 & abs(Wn - 0.06666666666667) < 0.00000000000001)
        % Wn for e.g. SampleRate=30 and Cutoff=1
        FiltNum = [0.00952576237620   0.01905152475239   0.00952576237620];
        FiltDen = [1.00000000000000  -1.70555214554408   0.74365519504887];
    elseif (N == 2 & Wn == 0.1)
        % Wn for e.g. SampleRate=30 and Cutoff=1.5
        FiltNum = [0.02008336556421   0.04016673112842   0.02008336556421];
        FiltDen = [1.00000000000000  -1.56101807580072   0.64135153805756];
    elseif (N == 2 & abs(Wn - 0.13333333333333) < 0.00000000000001)
        % Wn for e.g. SampleRate=30 and Cutoff=2
        FiltNum = [0.03357180936764   0.06714361873528   0.03357180936764];
        FiltDen = [1.00000000000000  -1.41898265221812   0.55326988968868];
    elseif (N == 2 & Wn == 0.2)
        % Wn for e.g. SampleRate=30 and Cutoff=3
        FiltNum = [0.06745527388907   0.13491054777814   0.06745527388907];
        FiltDen = [1.00000000000000  -1.14298050253990   0.41280159809619];
    elseif (N == 2 & abs(Wn - 0.26666666666667) < 0.00000000000001)
        % Wn for e.g. SampleRate=30 and Cutoff=4
        FiltNum = [0.10844743889023   0.21689487778045   0.10844743889023];
        FiltDen = [1.00000000000000  -0.87727063230739   0.31106038786830];
    elseif (N == 2 & abs(Wn - 0.33333333333333) < 0.00000000000001)
        % Wn for e.g. SampleRate=30 and Cutoff=5
        FiltNum = [0.15505102572168   0.31010205144336   0.15505102572168];
        FiltDen = [1.00000000000000  -0.62020410288673   0.24040820577346];
    elseif (N == 2 & Wn == 0.4)
        % Wn for e.g. SampleRate=30 and Cutoff=6
        FiltNum = [0.20657208382615   0.41314416765230   0.20657208382615];
        FiltDen = [1.00000000000000  -0.36952737735124   0.19581571265583];
    elseif (N == 2 & abs(Wn - 0.46666666666667) < 0.00000000000001)
        % Wn for e.g. SampleRate=30 and Cutoff=7
        FiltNum = [0.26287402958593   0.52574805917186   0.26287402958593];
        FiltDen = [1.00000000000000  -0.12274122501252   0.17423734335624];
    elseif (N == 2 & abs(Wn - 0.53333333333333) < 0.00000000000001)
        % Wn for e.g. SampleRate=30 and Cutoff=8
        FiltNum = [0.32424464209219   0.64848928418438   0.32424464209219];
        FiltDen = [1.00000000000000   0.12274122501252   0.17423734335624];
    elseif (N == 2 & Wn == 0.6)
        % Wn for e.g. SampleRate=30 and Cutoff=9
        FiltNum = [0.39133577250177   0.78267154500354   0.39133577250177];
        FiltDen = [1.00000000000000   0.36952737735124   0.19581571265583];
    elseif (N == 2 & abs(Wn - 0.66666666666667) < 0.00000000000001)
        % Wn for e.g. SampleRate=30 and Cutoff=10
        FiltNum = [0.46515307716505   0.93030615433009   0.46515307716505];
        FiltDen = [1.00000000000000   0.62020410288673   0.24040820577346];
        
        
        
    elseif (N == 5 & Wn == 0.04)
        % Wn for e.g. SampleRate=100 and Cutoff=2 or SampleRate=30 and
        % Cutoff=0.6
        FiltNum = 1e-5 * [0.08042356421933   0.40211782109667   0.80423564219334   0.80423564219334   0.40211782109667   0.08042356421933];
        FiltDen = [1.00000000000000  -4.59342139980769   8.45511522351013  -7.79491831804445   3.59890276805391  -0.66565253817136];
    elseif (N == 5 & Wn == 0.1)
        % Wn for e.g. SampleRate=100 and Cutoff=5
        FiltNum = 1e-3 * [0.05979578037002   0.29897890185010   0.59795780370020   0.59795780370020   0.29897890185010   0.05979578037002];
        FiltDen = [1.00000000000000  -3.98454311961234   6.43486709027587  -5.25361517035227   2.16513290972413  -0.35992824506356];
            
    elseif (N == 5 & abs(Wn - 0.06666666666667) < 0.00000000000001)
        % Wn for e.g. SampleRate=30 and Cutoff=1
        FiltNum = 1e-4 * [0.09132581781923   0.45662908909616   0.91325817819232   0.91325817819232   0.45662908909616   0.09132581781923];
        FiltDen = [1.00000000000000  -4.32259612675314   7.51418241128532  -6.56261229709249   2.87829142186758  -0.50697316669026];
    elseif (N == 5 & abs(Wn - 0.13333333333333) < 0.00000000000001)
        % Wn for e.g. SampleRate=30 and Cutoff=2
        FiltNum = [0.00021894062230   0.00109470311149   0.00218940622297   0.00218940622297   0.00109470311149   0.00021894062230];
        FiltDen = [1.00000000000000  -3.64722245584034   5.45962345438380  -4.16836695537251   1.61760081476554  -0.25462875802297];
    elseif (N == 5 & Wn == 0.2)
        % Wn for e.g. SampleRate=30 and Cutoff=3
        FiltNum = [0.00128258107896   0.00641290539480   0.01282581078961   0.01282581078961   0.00641290539480   0.00128258107896];
        FiltDen = [1.00000000000000  -2.97542210974568   3.80601811932041  -2.54525286833047   0.88113007543784  -0.12543062215536];
    elseif (N == 5 & abs(Wn - 0.26666666666667) < 0.00000000000001)
        % Wn for e.g. SampleRate=30 and Cutoff=4
        FiltNum = [0.00428223107420   0.02141115537098   0.04282231074195   0.04282231074195   0.02141115537098   0.00428223107420];
        FiltDen = [1.00000000000000  -2.30797359412991   2.52373656071397  -1.47990368259606   0.46106508390698  -0.05989297352073];
    elseif (N == 5 & abs(Wn - 0.33333333333333) < 0.00000000000001)
        % Wn for e.g. SampleRate=30 and Cutoff=5
        FiltNum = [0.01061191321752   0.05305956608762   0.10611913217524   0.10611913217524   0.05305956608762   0.01061191321752];
        FiltDen = [1.00000000000000  -1.64484891141637   1.58661518294383  -0.80488189477624   0.22994912012653  -0.02725227391698];
    elseif (N == 5 & Wn == 0.4)
        % Wn for e.g. SampleRate=30 and Cutoff=6
        FiltNum = [0.02193962068846   0.10969810344232   0.21939620688464   0.21939620688464   0.10969810344232   0.02193962068846];
        FiltDen = [1.00000000000000  -0.98532523927924   0.97384933183676  -0.38635655864845   0.11116384057834  -0.01126351245657];
    elseif (N == 5 & abs(Wn - 0.46666666666667) < 0.00000000000001)
        % Wn for e.g. SampleRate=30 and Cutoff=7
        FiltNum = [0.04026005941707   0.20130029708533   0.40260059417065   0.40260059417065   0.20130029708533   0.04026005941707];
        FiltDen = [1.00000000000000  -0.32816749900665   0.67110782133673  -0.11311142936997   0.06149993462651  -0.00300692624053];
    elseif (N == 5 & abs(Wn - 0.53333333333333) < 0.00000000000001)
        % Wn for e.g. SampleRate=30 and Cutoff=8
        FiltNum = [0.06802792533064   0.34013962665319   0.68027925330637   0.68027925330637   0.34013962665319   0.06802792533064];
        FiltDen = [1.00000000000000   0.32816749900665   0.67110782133673   0.11311142936997   0.06149993462651   0.00300692624053];
    elseif (N == 5 & Wn == 0.6)
        % Wn for e.g. SampleRate=30 and Cutoff=9
        FiltNum = [0.10837370258748   0.54186851293740   1.08373702587480   1.08373702587480   0.54186851293740   0.10837370258748];
        FiltDen = [1.00000000000000   0.98532523927924   0.97384933183676   0.38635655864845   0.11116384057834   0.01126351245657];
    elseif (N == 5 & abs(Wn - 0.66666666666667) < 0.00000000000001)
        % Wn for e.g. SampleRate=30 and Cutoff=10
        FiltNum = [0.16542335572437   0.82711677862186   1.65423355724373   1.65423355724373   0.82711677862186   0.16542335572437];
        FiltDen = [1.00000000000000   1.64484891141636   1.58661518294383   0.80488189477624   0.22994912012653   0.02725227391698];
    elseif (N == 5 & abs(Wn - 0.85714285714286) < 0.00000000000001)
        % Wn for e.g. SampleRate=30 and Cutoff=3/7*SampleRate
        FiltNum = [0.48006636447414   2.40033182237071   4.80066364474141   4.80066364474141   2.40033182237071   0.48006636447414];
        FiltDen = [1.00000000000000   3.55100511238095   5.19955919390169   3.89483521744061   1.48626051357714   0.23046362587214];
    
    else
        Warn = true;
        [FiltNum FiltDen] = butter(N, Wn);
    end
    
else
    ErrStr = 'Unexpected number of input parameters.';
end


if Warn
    warning('GetButterworthFilter:FilterParamsNotPrecalculated', 'Butterworth filter parameters not precalculated.')
    WarningState = warning('query', 'GetButterworthFilter:FilterParamsNotPrecalculated');
    if strcmp(WarningState.state, 'on')
        % output data that can be used for adding this filter to the
        % precalculated ones
        Cutoff
        Wn
        FiltNum
        FiltDen
    end
end

if ~isempty(ErrStr)
    error(ErrStr)
end
    