# create folder structure sub-#/anat/*.nii.gz for each file in input folder
# and copy files to new folder structure

import os
import shutil
import glob
import re
import argparse

parser = argparse.ArgumentParser(description='Sort xix dataset')
parser.add_argument('--input', type=str,
                    help='input folder')
parser.add_argument('--output', type=str,
                    help='output folder')
parser.add_argument('--count', type=int, default=0,
                    help='beginning of subject number')
args = parser.parse_args()
# dictionary of subject numbers
sub_dict = {}
sub_count = args.count
# create output folder
if not os.path.exists(args.output):
    files = glob.glob(args.input + '/*.nii.gz')
    for file in files:
        fname = os.path.basename(file)
        # get subject number
        # save the fname withouut the endindg nii.gz
        code =  re.sub(r'\.nii\.gz$', '', fname)
        # get subject number
        sub = f"sub-{sub_count}"
        sub_count += 1
        output_dirs = os.path.join(args.output, sub, 'anat')
        # create output folder
        os.makedirs(output_dirs, exist_ok=True)
        # copy file to output folder
        shutil.copy(file, os.path.join(output_dirs, f"{sub}_T1w.nii.gz"))
        # add to dictionary
        sub_dict[sub] = code
        # print progress to console with percentage and tab beginning of line
        print(f"progres: ... \r{round(sub_count/len(files)*100, 2)}%", end='\r')
    # save dictionary into csv file
    with open(os.path.join(args.output, 'sub_dict.csv'), 'w') as f:
        for key in sub_dict.keys():
            f.write("%s,%s\n"%(key,sub_dict[key]))

else:
    print("Output folder already exists. Exiting...")
    exit(1)

