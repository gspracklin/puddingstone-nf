#! /usr/bin/env nextflow

// Show help message
if (params.help) {
    helpMessage()
    exit 0
}

println "I will process $params.sample_name with: \n$params.cooler"


process runBlast {

  script:
  """
  blastn  -num_threads 2 -db $PWD/DB/blastDB -query $PWD/input.fasta -outfmt 6 -out input.blastout
  """

}


