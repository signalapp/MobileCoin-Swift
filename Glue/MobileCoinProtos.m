
// Order matters.
#include "attest.h"
#include "transaction.h"

#import <CocoaLumberjack/CocoaLumberjack.h>
#ifdef DEBUG
static const NSUInteger ddLogLevel = DDLogLevelAll;
#else
static const NSUInteger ddLogLevel = DDLogLevelInfo;
#endif

bool mc_tx_out_validate_confirmation_number(
                                            const McBuffer* MC_NONNULL tx_out_public_key,
                                            const McBuffer* MC_NONNULL tx_out_confirmation_number,
                                            const McBuffer* MC_NONNULL view_private_key,
                                            bool* MC_NONNULL out_valid
                                            )
{
    DDLogVerbose(@"Invalid method.");
}

bool mc_tx_out_get_value(
                         const McTxOutAmount* MC_NONNULL tx_out_amount,
                         const McBuffer* MC_NONNULL tx_out_public_key,
                         const McBuffer* MC_NONNULL view_private_key,
                         uint64_t* MC_NONNULL out_value,
                         McError* MC_NULLABLE * MC_NULLABLE out_error
                         )
{
    DDLogVerbose(@"Invalid method.");
}

bool mc_tx_out_get_subaddress_spend_public_key(
                                               const McBuffer* MC_NONNULL tx_out_target_key,
                                               const McBuffer* MC_NONNULL tx_out_public_key,
                                               const McBuffer* MC_NONNULL view_private_key,
                                               McMutableBuffer* MC_NONNULL out_subaddress_spend_public_key,
                                               McError* MC_NULLABLE * MC_NULLABLE out_error
                                               )
{
    DDLogVerbose(@"Invalid method.");
}

bool mc_tx_out_matches_subaddress(
                                  const McBuffer* MC_NONNULL tx_out_target_key,
                                  const McBuffer* MC_NONNULL tx_out_public_key,
                                  const McBuffer* MC_NONNULL view_private_key,
                                  const McBuffer* MC_NONNULL subaddress_spend_private_key,
                                  bool* MC_NONNULL out_matches
                                  )
{
    DDLogVerbose(@"Invalid method.");
}

bool mc_account_key_get_public_address_fog_authority_sig(
                                                         const McAccountKey* MC_NONNULL account_key,
                                                         uint64_t subaddress_index,
                                                         McMutableBuffer* MC_NONNULL out_fog_authority_sig
                                                         )
{
    DDLogVerbose(@"Invalid method.");
}

void mc_error_free(McError* MC_NULLABLE error)
{
    DDLogVerbose(@"Invalid method.");
}

bool mc_tx_out_matches_any_subaddress(
                                      const McTxOutAmount* MC_NONNULL tx_out_amount,
                                      const McBuffer* MC_NONNULL tx_out_public_key,
                                      const McBuffer* MC_NONNULL view_private_key,
                                      bool* MC_NONNULL out_matches
                                      )
{
    DDLogVerbose(@"Invalid method.");
}

ssize_t mc_printable_wrapper_b58_decode(
                                        const char* MC_NONNULL b58_encoded_string,
                                        McMutableBuffer* MC_NULLABLE out_printable_wrapper_proto_bytes,
                                        McError* MC_NULLABLE * MC_NULLABLE out_error
                                        )
{
    DDLogVerbose(@"Invalid method.");
}

bool mc_ristretto_private_validate(
                                   const McBuffer* MC_NONNULL ristretto_private,
                                   bool* MC_NONNULL out_valid
                                   )
{
    DDLogVerbose(@"Invalid method.");
}

char* MC_NULLABLE mc_printable_wrapper_b58_encode(
                                                  const McBuffer* MC_NONNULL printable_wrapper_proto_bytes
                                                  )
{
    DDLogVerbose(@"Invalid method.");
}

bool mc_account_key_get_public_address_public_keys(
                                                   const McBuffer* MC_NONNULL view_private_key,
                                                   const McBuffer* MC_NONNULL spend_private_key,
                                                   uint64_t subaddress_index,
                                                   McMutableBuffer* MC_NONNULL out_subaddress_view_public_key,
                                                   McMutableBuffer* MC_NONNULL out_subaddress_spend_public_key
                                                   )
{
    DDLogVerbose(@"Invalid method.");
}

bool mc_ristretto_public_validate(
                                  const McBuffer* MC_NONNULL ristretto_public,
                                  bool* MC_NONNULL out_valid
                                  )
{
    DDLogVerbose(@"Invalid method.");
}

bool mc_tx_out_get_key_image(
                             const McBuffer* MC_NONNULL tx_out_target_key,
                             const McBuffer* MC_NONNULL tx_out_public_key,
                             const McBuffer* MC_NONNULL view_private_key,
                             const McBuffer* MC_NONNULL subaddress_spend_private_key,
                             McMutableBuffer* MC_NONNULL out_key_image,
                             McError* MC_NULLABLE * MC_NULLABLE out_error
                             )
{
    DDLogVerbose(@"Invalid method.");
}

void mc_string_free(char* MC_NULLABLE string)
{
    DDLogVerbose(@"Invalid method.");
}

bool mc_account_key_get_subaddress_private_keys(
                                                const McBuffer* MC_NONNULL view_private_key,
                                                const McBuffer* MC_NONNULL spend_private_key,
                                                uint64_t subaddress_index,
                                                McMutableBuffer* MC_NONNULL out_subaddress_view_private_key,
                                                McMutableBuffer* MC_NONNULL out_subaddress_spend_private_key
                                                )
{
    DDLogVerbose(@"Invalid method.");
}
