#!/usr/bin/env nextflow
nextflow.enable.dsl=2

include { expected; insulation; eigs; saddle } from './modules'

Channel
      .fromPath(params.cooler)
      .map { [file(it).getSimpleName(), file(it)] }
      .set { cooler_ch }

workflow {

  expected (cooler_ch, params.expected.expectedOptions, params.expected.resolution) 
  insulation (cooler_ch, params.expected.resolution, params.expected.window)
  eigs (cooler_ch, params.expected.resolution)
  //saddle (cooler_ch, eigs.out, expected.out, params.expected.resolution)
}

