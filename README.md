# To run the script
```
julia --project=. run.jl
```

# To run in a Docker container
Uncomment lines 8 and 9 in `run.jl` and do:
```
docker run -t --rm --memory 3584000K --memory-swap 3584000K -v "$PWD":/MemoryLeak.jl -w /MemoryLeak.jl julia:1.8.2 julia --project=. run.jl
```