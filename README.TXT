
=== Free to use and distribute, as long as this statement is included =========

(c) 2006, Gustav Markkula and Johan Engström, Volvo Technology Corporation.

This is a MATLAB implementation of the Steering Wheel Reversal Rate (SWRR) metric described in: 

Markkula, G. and Engström, J. (2006). A Steering Wheel Reversal Rate Metric for Assessing Effects of Visual and Cognitive Secondary Task Load. Proceedings of the 13th ITS World Congress. October 8-12, 2006, London, UK. (Available as of March 2020 at: http://eprints.whiterose.ac.uk/131534/)

If you use this code to support a paper or report, please cite the paper above.

===============================================================================

This method for calculating SWRR is also standardised by SAE:

Society of Automotive Engineers (2015). Standard J2944_201506: Operational definitions of driving performance measures and statistics. (Available as of March 2020 at: https://www.sae.org/standards/content/j2944_201506/)

===============================================================================

This code has been confirmed to work with MATLAB R2017a and several earlier releases. If using it with filtering settings for which Butterworth filter parameters have not been precalculated (see GetButterworthFilter.m below), the code requires MATLAB Signal Processing Toolbox to be present.

===============================================================================


Contents of archive:


--- metric_ReversalRate_VTEC.m

The implementation of the metric. Type 'help metric_ReversalRate_VTEC' in MATLAB for calling syntax.


--- GetButterworthFilter.m

A function used in the metric implementation. It has precalculated Butterworth filter parameters for a number of filters. If a filter is requested that is not precalculated a warning is given, since this will slow down metric calculation if the number of sequences to analyse is large. Type 'help GetButterworthFilter' in MATLAB for calling syntax, and for information on how to turn off the warning, if needed. Adding new precalculated filter parameters is also an option, and it should be obvious from the code how this is done.


--- test_ReversalRate_VTEC.m

An example script showing how to use the metric implementation. It uses the filter settings and gap sizes recommended in the Markkula and Engström (2006) paper to compare one example baseline driving recording with two example recordings of visually and cognitively distracted driving, respectively. Type 'test_ReversalRate_VTEC' in MATLAB to run it.


--- TestSequences.mat

Data file containing the three example steering wheel sequences used by the example script.



Send any questions to Gustav Markkula (E-mail address as of March 2020: g.markkula@leeds.ac.uk)
