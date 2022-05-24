#! /usr/bin/env nextflow
//nextflow.enable.dsl=2

def helpMessage() {
  log.info """
        Usage:
        The typical command for running the pipeline is as follows:
        nextflow run main.nf --query QUERY.fasta --dbDir "blastDatabaseDirectory" --dbName "blastPrefixName"

        Mandatory arguments:
         --query                        Query fasta file of sequences you wish to BLAST
         --dbDir                        BLAST database directory (full path required)
         --dbName                       Prefix name of the BLAST database

       Optional arguments:
        --outdir                       Output directory to place final BLAST output
        --outfmt                       Output format ['6']
        --options                      Additional options for BLAST command [-evalue 1e-3]
        --outFileName                  Prefix name for BLAST output [input.blastout]
        --threads                      Number of CPUs to use during blast job [16]
        --chunkSize                    Number of fasta records to use when splitting the query fasta file
        --app                          BLAST program to use [blastn;blastp,tblastn,blastx]
        --help                         This usage statement.
        """
}

// Show help message
if (params.help) {
    helpMessage()
    exit 0
}

Channel
    .fromPath(params.query)
    .splitFasta()
    .into {queryFile_ch}

process expected{

  input:
  path queryFile from queryFile_ch
  
  output:
  publishDir "${params.outdir}/expected"
  path(params.outFileName) into expected_output_ch

  script:
    """
    cooltools compute-expected -p $params.threads --no-balance --output test.ciseig.tsv $params.cooler
    """

}

expected_output_ch
    .collectFile(name: 'expected_output_combined.txt', storeDir: params.outdir)