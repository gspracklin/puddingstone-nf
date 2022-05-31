nextflow.enable.dsl=2

process expected {
  tag "$sample_id"

  publishDir params.output.expected
  
  input:
    tuple val (sample_id), path (cooler) 
    val expectedOptions
    val resolution

  output:
    path "${sample_id}*"
 
  script:
  """
  cooltools expected-cis $expectedOptions -o ${sample_id}.${resolution}.expected.txt $cooler::resolutions/$resolution
  
  """

}


process insulation {
  tag "$sample_id"

  publishDir params.output.insulation

  input:
    tuple val (sample_id), path (cooler)
    val resolution
    val window

  output:
    path "${sample_id}*"

  script:
  """
  cooltools insulation --bigwig --output ${sample_id}.res${resolution}.win${window}.insulation.txt $cooler::resolutions/$resolution $window
  """
}

process eigs {
  tag "$sample_id"

  publishDir params.output.eigs
  
  input:
    tuple val (sample_id), path (cooler)
    val resolution 

  output:
    //tuple path (".*bw"), path ("*lam.txt"), path ("*vecs.tsv")
    path "${sample_id}*"
 
  script:
  """
  cooltools eigs-cis --bigwig -o ${sample_id}.cis_eigs $cooler::resolutions/$resolution
  
  """
}

process saddle {
  tag "$sample_id"

  publishDir params.output.saddle
  
  input:
    tuple val (sample_id), path (cooler) 
    val eigs
    val expected
    val resolution

  output:
    path "${sample_id}*"
 
  script:
  """
  cooltools saddle --fig png  -o ${sample_id}.saddle.txt $cooler::resolutions/$resolution ${eigs[2]}::E1 $expected
  
  """
}