# NonnegMatrixFactor

This Julia repo implements a variety of Nonnegative Matrix Factorization (NMF) models in [Julia](https://julialang.org), a [fast](https://julialang.org/benchmarks/), flexible and free programming language. NMF attempts to solve the optimization problem

```
minimize D(X || W H) s.t. W >= 0, H >= 0
```

where `D(X || W H)` is some distance metric between `X` and `W H`.

## Usage

Fitting an NMF model is easy. Simply choose your algorithm and any relevant hyperparemeters. For example,

```julia
>> using NonnegMatrixFactor
>> results = fit_nmf(data, alg=:mult, K=3, max_itr=100)
>>
>> using Plots
>> plot(results.time_hist, results.loss_hist)
```

![alt text](https://github.com/degleris1/NonnegMatrixFactor/raw/master/docs/loss-demo.png "Loss Plot")


## Installation

First, download and install the latest version of [Julia](https://julialang.org/downloads/). Then install the `NonnegMatrixFactor` package:

```julia
using Pkg
Pkg.add("NonnegMatrixFactor")
```

## Supported Features

The following NMF models and algorithms are available

- Frobenius norm loss (square error)
  - Multiplicative Updates (`alg=:mult`)
  - Hierachical Alternating Least Squares (`alg=:hals`)
  - Projected Alternaing Least Squares (`alg=:projals`)
