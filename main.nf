#! /usr/bin/env nextflow

sample_name = "first_sample" 
params.cooler = "sample.mapq30.1000.mcool" 

println "I will process $sample_name with this cooler: $params.cooler"