# HybridPSODevelopment
## Depiction
This is an project of Department of Mechanical Engeneering of SUSTech.
The goal of this project is to develop a hybrid PSO algorithm for optimization in roller multi-pass grinding optimization.
## Introduction

### Two key aspects of PSO:
1. It is well-known that one of the most important features of the PSO algorithm is its fast convergence.
2. PSO is relatively simple and its implementation is straightforward.
PSO produce good results at low computational cost in a lot of application.

### MOPSO
Three main goals to achieve :
1. Maximize number of elements of the Pareto optimal set found.
2. Minimize the distance of the Pareto front produced by our algorithm with respect to the true (global ) Pareto front.
3. Maximize the spread of solutions found (to have a distribution of vectors as smooth and uniform as possible)

## Research Plan
The finest matlab code presents on the internet is a MOPSO code which uses superposition method to deal with multiple objectives, and doesn’t have a system to handle the multiple constraints. In the optimization process for multi-process roller grinding, multiple constraints for solutions is a must have things due to the restriction for parameters on the roller grinding machine. So my plan would be first,  develop an algorithm that actually works (regardless of how well it works) with multiple objectives and multiple constraint. Then I would try to improve the algorithm with some newest methods that finely take care of problems stated above.

## Reference
1.	Zhang, H., et al., A process parameters optimization method of multi-pass dry milling for high efficiency, low energy and low carbon emissions. Journal of Cleaner Production, 2017. 148: p. 174-184.
2.	Gao, L., J. Huang, and X. Li, An effective cellular particle swarm optimization for parameters optimization of a multi-pass milling process. Applied Soft Computing, 2012. 12(11): p. 3490-3499.
3.	Coello, M.R.-S.C.A.C., Multi-Objective Particle Swarm Optimizers: A Survey of the State-of-the-Art. International Journal of Computational Intelligence Research., 2006. Vol.2(No.3): p. pp. 287–308.
4.	施建鸿, 最优化潮流算法综述. 中国科技信息, 2016. 第 01 期.
5.	Elbeltagi, E., T. Hegazy, and D. Grierson, Comparison among five evolutionary-based optimization algorithms. Advanced Engineering Informatics, 2005. 19(1): p. 43-53.
6.	Sanaz Mostaghim and Jürgen Teich. The role of "- dominance in multi objective particle swarm optimization methods. In Congress on Evolutionary Computation (CEC’2003), volume 3, pages 1764–1771, Canberra, Australia, December 2003. IEEE Press.
7.         Yuhui Shi and Russell Eberhart. Parameter selection in particle swarm optimization. In Evolutionary Programming VII: Proceedings of the Seventh annual Conference on Evolutionary Programming, pages 591–600, New York, USA, 1998. Springer-Verlag.
8.	Yuhui Shi and Russell Eberhart. Empirical study of particle swarm optimization. In Congress on Evolutionary Computation (CEC’1999), pages 1945–1950, Piscataway, NJ, 1999. IEEE Press.

9.	Konstantinos E. Parsopoulos and Michael N. Vrahatis. Particle swarm optimization method in multiobjective problems. In Proceedings of the 2002 ACM Symposium on Applied Computing (SAC’2002), pages 603– 607, Madrid, Spain, 2002. ACM Press.  
10.	 U. Baumgartner, Ch. Magele, and W. Renhart. Pareto optimality and particle swarm optimization. IEEE Transactions on Magnetics, 40(2):1172–1175, March 2004.

*test*
