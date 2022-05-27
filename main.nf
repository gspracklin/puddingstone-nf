#!/usr/bin/env nextflow
nextflow.enable.dsl=2

//TODO
//$tasks.cpus
//docker
//build tests

include { expected; insulation } from './modules'

Channel
      .fromPath(params.cooler)
      .map { [file(it).getSimpleName(), file(it)] }
      .set { cooler_ch}

workflow {

  expected (cooler_ch, params.expectedOptions, params.resolution) 
  //insulation (cooler_ch, params.insulationName, params.resolution, params.window)
}

