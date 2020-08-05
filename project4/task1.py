#!/usr/bin/env python3

import sys
import os
import numpy
import numpy.linalg
import scipy.misc

def getOutputPngName(path, rank):
    filename, ext = os.path.splitext(path)
    return filename + '.' + str(rank) + '.png'

def getOutputNpyName(path, rank):
    filename, ext = os.path.splitext(path)
    return filename + '.' + str(rank) + '.npy'

if len(sys.argv) < 3:
    sys.exit('usage: task1.py <PNG inputFile> <rank>')

inputfile = sys.argv[1]
rank = int(sys.argv[2])
outputpng = getOutputPngName(inputfile, rank)
outputnpy = getOutputNpyName(inputfile, rank)

#
# TODO: The current code just prints out what it is supposed to to
#       Replace the print statement wth your code
#

# Load image file
img = scipy.misc.imread(inputfile)

# SVD
U, s, V = numpy.linalg.svd(img, full_matrices=False)

# Keep only the top-k entries in the SVD decomposed matrices and multiply them to obtain the best rank-k approximation of the original array (the k value should come from the second command-line argument of task1.py)
S = numpy.diag(s[:rank])
kApprox = numpy.dot(U[:, :rank], numpy.dot(S, V[:rank, :]))

# Save the approximated array as (1) a binary array file (with the name from the getOutputNpyName function call) using numpy.save function and (2) a PNG file (with the name from the getOutputPngName function call) using the scipy.misc.imsave function.
numpy.save(outputnpy, kApprox)
scipy.misc.imsave(outputpng, kApprox)

# print("This program should read %s file, perform rank %d approximation, and save the results in %s and %s files." % (inputfile, rank, outputpng, outputnpy))
