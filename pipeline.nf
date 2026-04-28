nextflow.enable.dsl=2

params.filepath = "/home/user/DM21420_1.fastq.gz"
params.genome = "/home/user/genome_ref.fasta"
params.input_forward = "/home/user/DM21420_1.fastq.gz"
params.input_reverse = "/home/user/DM21420_2.fastq.gz"

process FastQC {
    input:
    path filepath

    output:
    path "*_fastqc.zip", emit: fastqc_results

    script:
    """
    fastqc $filepath -o ./
    """
}

process BWA_index {
    input:
    path genome

    output:
    path "${genome}.*", emit: bwa_index_files

    script:
    """
    bwa index $genome
    """
}

process Trimmomatic {
    input:
    path forward
    path reverse

    output:
    path "*_paired.fq.gz", emit: trimmed_reads

    script:
    """
    trimmomatic PE -phred33 $forward $reverse \\
    output_forward_paired.fq.gz output_forward_unpaired.fq.gz \\
    output_reverse_paired.fq.gz output_reverse_unpaired.fq.gz \\
    SLIDINGWINDOW:4:20 MINLEN:60
    """
}

process BWA_mem {
    input:
    path trimmed_fastq
    path index_files

    output:
    path "output.sam", emit: bwa_mem_results

    script:
    def prefix = index_files[0].baseName
    """
    bwa mem $prefix ${trimmed_fastq[0]} ${trimmed_fastq[1]} > output.sam
    """
}

workflow {
    FastQC(params.filepath)

    BWA_index(params.genome)

    Trimmomatic(params.input_forward, params.input_reverse)

    BWA_mem(Trimmomatic.out.trimmed_reads, BWA_index.out.bwa_index_files.collect())
}
