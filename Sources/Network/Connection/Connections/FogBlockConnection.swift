//
//  Copyright (c) 2020-2021 MobileCoin. All rights reserved.
//

import Foundation
import GRPC
import LibMobileCoin

final class FogBlockConnection:
    Connection<FogBlockGrpcConnection, FogBlockHttpConnection>, FogBlockService
{
    private let config: ConnectionConfig<FogUrl>
    private let channelManager: GrpcChannelManager
    private let targetQueue: DispatchQueue?

    init(
        config: ConnectionConfig<FogUrl>,
        channelManager: GrpcChannelManager,
        httpRequester: HttpRequester?,
        targetQueue: DispatchQueue?
    ) {
        self.config = config
        self.channelManager = channelManager
        self.targetQueue = targetQueue

        super.init(
            connectionOptionWrapperFactory: { transportProtocolOption in
                switch transportProtocolOption {
                case .grpc:
                    return .grpc(
                        grpcService: FogBlockGrpcConnection(
                            config: config,
                            channelManager: channelManager,
                            targetQueue: targetQueue))
                case .http:
                    guard let requester = httpRequester else {
                        logger.fatalError("Transport Protocol is .http but no HttpRequester provided")
                    }
                    return .http(httpService: FogBlockHttpConnection(
                                    config: config,
                                    requester: RestApiRequester(requester: requester, baseUrl: config.url.httpBasedUrl),
                                    targetQueue: targetQueue))
                }
            },
            transportProtocolOption: config.transportProtocolOption,
            targetQueue: targetQueue)
    }

    func getBlocks(
        request: FogLedger_BlockRequest,
        completion: @escaping (Result<FogLedger_BlockResponse, ConnectionError>) -> Void
    ) {
        switch connectionOptionWrapper {
        case .grpc(let grpcConnection):
            grpcConnection.getBlocks(request: request, completion: completion)
        case .http(let httpConnection):
            httpConnection.getBlocks(request: request, completion: completion)
        }
    }
}
