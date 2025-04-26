# puddingstone-nf

A Nextflow pipeline for Hi-C data analysis using cooltools, focusing on expected interactions, insulation scores, eigenvectors, and saddle plots.

## Overview

This pipeline processes `.mcool` files to generate various Hi-C analysis outputs including:
- Expected interaction frequencies
- Insulation scores
- Compartment analysis (eigenvectors)
- Saddle plots

## Requirements

- Nextflow (>=21.04.0)
- Docker or Conda
- Input `.mcool` files

## Installation

1. Clone the repository:
```bash
git clone https://github.com/gspracklin/puddingstone-nf
cd puddingstone-nf
```

2. Choose your execution environment:
   - Docker (recommended)
   - Conda environment
   - Singularity

## Usage

Basic usage:
```bash
nextflow run main.nf -profile docker
```

### Configuration Profiles

- `docker`: Runs pipeline in Docker container
- `standard`: Runs pipeline locally
- `slurm`: Runs pipeline on SLURM cluster
- `singularity`: Runs pipeline using Singularity

### Input Parameters

Configure your analysis in `project.yml`:

```yaml
cooler: './path/to/*.mcool'  # Input cooler files

expected:
    expectedOptions: "-p 2"   # Options for expected calculation
    resolution: 20000         # Resolution in base pairs
    window: 100000           # Window size for insulation score
    threads: 4               # Number of threads
```

### Output Directories

- `results/expected/`: Expected interaction frequencies
- `results/insulation/`: Insulation scores and boundaries
- `results/eigenvectors/`: Compartment analysis results
- `results/saddle/`: Saddle plots

## Pipeline Components

### 1. Expected Interactions
Calculates the expected interaction frequencies as a function of genomic distance.

### 2. Insulation Analysis
Computes insulation scores and identifies domain boundaries.

### 3. Eigenvector Analysis
Performs compartment analysis using eigenvector decomposition.

### 4. Saddle Analysis
Generates saddle plots to visualize compartment strength.

## Resource Requirements

- Default: 4 CPUs
- Memory: Scales with input file size
- Storage: ~2-3x input file size

## Support

For issues and questions, please open an issue on GitHub.

## Citation

If you use this pipeline, please cite:
- cooltools
- This pipeline

## License

This project is licensed under MIT License.