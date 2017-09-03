# HybridPSODevelopment
## Depiction
<br>This project aimed to develop extended PSO algorithm that is of praticle value for optimization problems in real engineering.

## Features of the algorithm:
### 1. Multple objectives
  Two sets of codes, uses relatively *density measure* and *superposition method* when select leader for the searm is provided.
### 2. Multiple constraints
  In all codes provided, multiple constraints are handled with *feasible area* method (which is proved to be a more efficient method compared to basic *projection method* ).

### 3. Setable weights on different objectives
  Although codes selecting leader with density measure is provided, all codes select a final global optima relys on *Grid Index*, which is essentially superposition of objective functions. The weights attached to different objectives are setable.

### 4. Produces a unique global optima together with Pareto Front
  The codes in the pack are set to graph the Pareto Front, as well as using a blue square to suggest position of the global optima. Codes which can be used to graph the process of all particles together with Pareto Front is also reserved (and commented). However there may be particles whose values of objective functions might include imaginary numbers, so it's not suggested to be used.

## Codes in the pack
### MOPSO(density meausre method)
Matlab codes of MOPSO algorithm uses density measure.
#### mopsoDensityMeasure
Basic MOPSO using density measure.
#### mopsoVariantParameter
MOPSO using density measure, and improved with vairnt weight and learning factor (c1 and c2) duirng runtime.
(I've examined this two algorithms in several different ways, but end up failling to decide which one performs better).
### MOPSO(Superposition Method)
MOPSO using superposition method and basic, non-variant coeeficient.

# Reference
Original Codes from : https://www.mathworks.com/matlabcentral/fileexchange/52870-multi-objective-particle-swarm-optimization--mopso-

More detaied description will be presented in technical document (which by now, may still reamianed unfinished).

You are welcome to contact me for any problems at:
derizsy@foxmail.com

*new test on fork*
*test 2*
*new new test*
