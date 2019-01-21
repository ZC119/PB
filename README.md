# Persistence B-Spline Grids: Stable Vector Representation of Persistence Diagrams

This is an implementation of Persistence B-Spline Grids on Matlab and Python3. 

## Installation

To run the code, we should install some requirements:
```python
pip install numpy matplotlib scikit-tda tqdm seaborn pandas scikit-learn
```

## Example

We support an example of Persistence B-Spline of toydata. It's a simple synthetic toy data set that contained a circle with its radius 0.4, two concentric circles with their radii 0.2 and 0.4, respectively, two disjoint circles with both their radii 0.2, a cluster of points sampled at random in the normal square, and two clusters of points sampled at random separately in two squares with edge length 0,5. All data were sampled in the range of [−0.5, 0.5]^2 on the 2D plane.

![](./img/toydata.png)

1. Run 'generate_toydata.ipynb' to generate PDs in 'PD_toydata' folder.
2. Run Matlab code 'main.m' to compute PB of PD. The results are saved in 'PB' folder.
3. Run 'classify.ipynb' and see the accuracy of classification.

![](./img/acc.png)