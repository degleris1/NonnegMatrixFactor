# NonnegMatrixFactor

This Julia repo implements a variety of Nonnegative Matrix Factorization (NMF) models in Julia.

## Usage

Fitting an NMF model is easy. Simply choose your algorithm and any relevant hyperparemeters. For example,

```julia
>> using NonnegMatrixFactor
>> results = fit_nmf(data, K=3, max_itr=100)
```

## Setup

## Supported Features
