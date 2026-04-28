# DNA-Seq Alignment Pipeline (Nextflow DSL2)

This repository contains a modular bioinformatical pipeline built with **Nextflow DSL2**. The workflow is designed to process raw DNA sequencing reads, perform quality control, and align them to a reference genome.

## Pipeline Workflow
The pipeline consists of the following automated steps:
1. **Quality Control (FastQC):** Generates reports to assess the quality of raw sequencing data.
2. **Read Trimming (Trimmomatic):** Performs adapter clipping and quality filtering for paired-end reads.
3. **Genome Indexing (BWA Index):** Prepares the reference genome for alignment.
4. **Read Mapping (BWA Mem):** Aligns the processed reads to the reference genome to produce a SAM file.

## Requirements
To run this pipeline, you need to have the following tools installed:
- [Nextflow](https://www.nextflow.io/) (version 20.07.0 or later)
- FastQC
- Trimmomatic
- BWA

## Usage
1. Configure your file paths in the `params` section of the script or via a config file.
2. Run the pipeline using the following command:
   ```bash
   nextflow run pipeline.nf

## Configuration
The pipeline is highly configurable through parameters:
* ```params.filepath:``` Path to the input FASTQ file for QC.

* ```params.genome:``` Path to the reference genome (FASTA).

* ```params.input_forward / params.input_reverse:``` Paths to paired-end reads for trimming and alignment.
