#!/usr/bin/env python2.7
# -*- coding: utf-8 -*-

import os
import sys
import argparse
import shutil
import subprocess

git_repo_path = os.path.abspath(subprocess.check_output(['git', 'rev-parse', '--show-toplevel']).strip())

def copy_path(path, src_repo_name, dst_prefix = None):

    print 'Copying:', path

    src_repo_path = os.path.abspath(os.path.join(git_repo_path, "..", src_repo_name))
    if not os.path.exists(src_repo_path):
        print("Source repo not found:", src_repo_path)

    src_file_path = os.path.join(src_repo_path, path)
    if not os.path.exists(src_file_path):
        print("Source file not found:", src_file_path)

    dst_file_path = git_repo_path
    if dst_prefix is not None:
        dst_file_path = os.path.join(dst_file_path, dst_prefix)
    dst_file_path = os.path.join(dst_file_path, path)
    if os.path.exists(dst_file_path):
        print("Destination file already exists:", dst_file_path)

    dst_parent_path = os.path.dirname(dst_file_path)
    if not os.path.exists(dst_parent_path):
        os.makedirs(dst_parent_path)
    
    # shutil.copyfile(src_file_path, dst_file_path)
    
    lines_to_remove = set([
        "import LibMobileCoin",
        ])
    substrings_to_replace = {
        # 'MobileCoin.Scheme': 'Scheme',
        'MobileCoin.Scheme': 'MobileCoinProtos.Scheme',
        # '@testable import MobileCoin': '@testable import MobileCoinProtos',
        'import MobileCoin': 'import MobileCoinProtos',
        ': XCTestCase {': ': MobileCoinProtosSwiftTest {',
    }

    with open(src_file_path, 'rt') as f:
        text = f.read()
    lines = text.split('\n')
    new_lines = []
    for line in lines:
        if line in lines_to_remove:
            continue
        for (before, after) in substrings_to_replace.items():
            line = line.replace(before, after)
        new_lines.append(line)
    lines = new_lines
    # lines = [line for line in lines if line not in lines_to_remove]
    text = '\n'.join(lines)
    with open(dst_file_path, 'wt') as f:
        f.write(text)

    if not os.path.exists(dst_file_path):
        print("Destination file missing:", dst_file_path)
    
    
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Precommit script.')
    args = parser.parse_args()

    dst_root_paths = [
        "Sources",
        "LibMobileCoin",
        "Tests",
    ]
    for dst_root_path in dst_root_paths:
        dst_dir_path = os.path.join(git_repo_path, dst_root_path)
        if os.path.exists(dst_dir_path):
            shutil.rmtree(dst_dir_path)
        
        
    mc_swift_paths = [
        "Sources/Common/CustomRedactingStringConvertible.swift",
        "Sources/Common/MobileCoinLogging.swift",
        "Sources/Utils/Locks/ImmutableOnceReadLock.swift",
        "Sources/Utils/Locks/ReadWriteDispatchLock.swift",
    ]
    for path in mc_swift_paths:
        copy_path(path, "MobileCoin-Swift")
        
    mc_swift_paths = [
        "Sources/Generated/Proto/external.pb.swift",
        "Artifacts/include/attest.h",
        "Artifacts/include/common.h",
        "Artifacts/include/keys.h",
        "Artifacts/include/transaction.h",
        "Artifacts/include/fog.h",
    ]
    for path in mc_swift_paths:
        copy_path(path, "libmobilecoin-ios-artifacts", dst_prefix = "LibMobileCoin")
        