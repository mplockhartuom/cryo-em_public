#!/bin/bash

##############################
#                            #
# Gauto-templates script 0.1 #
#                            #
##############################

# Please learn how to use Gautomatch before using this script
# It is designed as a useful tool rather than an excuse not to
#
# Run this script from the same place you would run Relion (top directory)
#
# First a directory is made for running gautomatch
mkdir gauto_templates

# Moving into the 'gauto_templates' directory, symbolic links are made to micrographs
cd gauto_templates
ln -sf ../Micrographs/*.mrc .

# Variables
echo What is the apix of the Micrographs?
read apixM

echo What is the particle diameter \(\Å\)?
read diameter_var

# Th4e templates should be in the 'top' directory.
echo What is the apix of the templates?
read apixT

echo What is the name of the template stack?
read template_stack

# Gautomatch 0.53 is run with a Gaussian blob.
# All required commands should have been added.
# Any additional commands can be added manually.
/programs/x86_64-linux/gautomatch/0.53/bin/Gautomatch-v0.53_sm_20_cu7.5_x86_64 --apixM $apixM --diameter $diameter_var --apixT $apixT --t ../$template_stack *.mrc

# Here we wait for Gautomatch to finish
wait

# Moving to the 'Micrographs' directory we can make new symbolic links to the 
# automatched particles in 'gauto'
rename "s/automatch/automatch_template/g" *automatch.star
cd ../Micrographs
ln -sf ../gauto_templates/*automatch_template.star .
