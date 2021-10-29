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
        # "Sources/Transaction/Receipt.swift",
        # "Sources/Transaction/Outputs/TxOutConfirmationNumber.swift",
        # "Sources/Crypto/CryptoUtils.swift",
        # "Sources/Crypto/RistrettoPublic.swift",
        # "Sources/Utils/Data/Data32.swift",
        # "Sources/Utils/Data/DataConvertible.swift",
        # "Sources/LibMobileCoin/asMcBuffer.swift",
        # "Sources/Utils/Data/MutableData.swift",
        # "Sources/Ledger/TxOut.swift",
        # "Sources/Ledger/TxOutProtocol.swift",
        # "Sources/Ledger/TxOutUtils.swift",
        # "Sources/Account/AccountKey.swift",
        # "Sources/Common/Errors.swift",
        # "Sources/Ledger/BlockMetadata.swift",
        # "Sources/Crypto/RistrettoPrivate.swift",
        # "Sources/Account/PublicAddress.swift",
        # "Sources/LibMobileCoin/McConstants.swift",
        # "Sources/Account/AccountKeyUtils.swift",
        # "Sources/Network/Url/FogUrl.swift",
        # "Sources/LibMobileCoin/CStructWrapper.swift",
        # "Sources/Ledger/KeyImage.swift",
        # "Sources/Network/Url/MobileCoinUrl.swift",
        "Sources/Common/CustomRedactingStringConvertible.swift",
        # "Sources/Encodings/Base58Coder.swift",
        # "Sources/LibMobileCoin/ProtoTypes+InfallibleDataSerializable.swift",
        # "Sources/Utils/Serialization/InfallibleDataSerializable.swift",
        # "Sources/LibMobileCoin/McError.swift",
        # "Sources/Encodings/PaymentRequest.swift",
        # "Sources/Encodings/TransferPayload.swift",
        # "Sources/LibMobileCoin/LibMobileCoinError.swift",
        "Sources/Common/MobileCoinLogging.swift",
        # "Sources/LibMobileCoin/Data32+withMcMutableBuffer.swift",
        # "Sources/Encodings/PrintableWrapper+Base58.swift",
        "Sources/Utils/Locks/ImmutableOnceReadLock.swift",
        # "Sources/LibMobileCoin/ProtoExtensions.swift",
        "Sources/Utils/Locks/ReadWriteDispatchLock.swift",
        # "Sources/Fog/View/FogRngKey.swift",
        # "Sources/Utils/Data/Data+MutableData.swift",
        # "Sources/LibMobileCoin/Data+withMcMutableBuffer.swift",
        # "Sources/LibMobileCoin/McString.swift",
        #
        # "Sources/Mnemonic/Mnemonic.swift",
        # "Sources/Mnemonic/Bip39Utils.swift",
        # "Sources/Transaction/TransactionBuilder.swift",
        # "Sources/Mnemonic/AccountKey+Mnemonic.swift",
        # "Sources/Mnemonic/Slip10Utils.swift",
        # "Sources/Transaction/Inputs/PreparedTxInput.swift",
        # "Sources/Utils/TypeConstraints/PositiveInt.swift",
        # "Sources/Fog/Report/FogResolver.swift",
        # "Sources/Utils/SecurityRNG.swift",
        # "Sources/Ledger/KnownTxOut.swift",
        # "Sources/Ledger/TxOutMembershipProof.swift",
        # "Sources/Network/Attestation/Attestation.swift",
        # "Sources/Network/Attestation/AttestationVerifier.swift",
        # "Sources/Transaction/Transaction.swift",
        # "Sources/Ledger/LedgerTxOut.swift",
        # "Sources/Utils/Encoding/DataConvertible+HexEncoding.swift",
        # "Sources/Utils/Encoding/HexEncoding.swift",
        # "Sources/Utils/SafeArithmetic/UnsignedInteger+SafeComparison.swift",
        # "Sources/Ledger/PartialTxOut.swift",
        # "Sources/Utils/Collection+Chunked.swift",
        # "Sources/Utils/SafeArithmetic/UnsignedInteger+SafeArithmetic.swift",
        # "Sources/LibMobileCoin/McRngCallback.swift",
        # "Sources/LibMobileCoin/McData.swift",
        # "Sources/Utils/Collection+Result.swift",
        # # Tests
        # "Tests//Unit/Transaction/ReceiptPublicApiTests.swift",
        # "Tests//Common/Fixtures/Transaction/Receipt+Fixtures.swift",
        # "Tests/Common/Fixtures/Account/AccountKey+Fixtures.swift",
        # "Tests/Common/Utils/TestRng.swift",
    ]
    for path in mc_swift_paths:
        copy_path(path, "MobileCoin-Swift")
        
    mc_swift_paths = [
        # "Sources/Generated/Proto/attest.pb.swift",
        # "Sources/Generated/Proto/view.pb.swift",
        "Sources/Generated/Proto/external.pb.swift",
        # "Sources/Generated/Proto/printable.pb.swift",
        # "Sources/Generated/Proto/fog_common.pb.swift",
        # "Sources/Generated/Proto/kex_rng.pb.swift",
        # "Sources/Generated/Proto/ledger.pb.swift",
        # "Sources/Generated/Proto/report.pb.swift",
        # "Sources/Generated/Proto/watcher.pb.swift",
        # "Artifacts/include/encodings.h",
        "Artifacts/include/attest.h",
        "Artifacts/include/common.h",
        # "Artifacts/include/crypto.h",
        "Artifacts/include/keys.h",
        "Artifacts/include/transaction.h",
        "Artifacts/include/fog.h",
        #
        # "Artifacts/include/bip39.h",
        # "Artifacts/include/slip10.h",
    ]
    for path in mc_swift_paths:
        copy_path(path, "libmobilecoin-ios-artifacts", dst_prefix = "LibMobileCoin")
        