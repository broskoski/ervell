import gql from 'graphql-tag';

import blockLightboxConnectionsFragment from 'react/components/BlockLightbox/components/BlockLightboxConnections/fragments/blockLightboxConnections';

export default gql`
  query BlockLightboxConnections($id: ID!) {
    block: blokk(id: $id) {
      ...BlockLightboxConnections
    }
  }
  ${blockLightboxConnectionsFragment}
`;