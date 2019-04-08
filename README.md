# NonnegMatrixFactor

This Julia repo implements a variety of Nonnegative Matrix Factorization (NMF) models in Julia.

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


## Setup

## Supported Features

The following NMF models and algorithms are available

- Frobenius norm loss (square error)
  - Multiplicative Updates (`:mult`)
  - Hierachical Alternating Least Squares (`:hals`)
