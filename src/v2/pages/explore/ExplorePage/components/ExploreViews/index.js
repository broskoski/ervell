import React, { Component } from 'react'
import PropTypes from 'prop-types'

import ExploreContents from 'v2/components/ExploreContents'

const All = ({ sort, fetchPolicy }) => (
  <ExploreContents type="ALL" sort={sort} fetchPolicy={fetchPolicy} />
)

All.propTypes = {
  sort: PropTypes.oneOf(['UPDATED_AT', 'RANDOM']).isRequired,
  fetchPolicy: PropTypes.oneOf(['cache-first', 'network-only']).isRequired,
}

const Blocks = ({ sort, fetchPolicy, block_filter }) => (
  <ExploreContents
    type="CONNECTABLE"
    sort={sort}
    fetchPolicy={fetchPolicy}
    block_filter={block_filter}
  />
)

Blocks.propTypes = {
  sort: PropTypes.oneOf(['UPDATED_AT', 'RANDOM']).isRequired,
  fetchPolicy: PropTypes.oneOf(['cache-first', 'network-only']).isRequired,
  block_filter: PropTypes.oneOf([
    'IMAGE',
    'EMBED',
    'TEXT',
    'ATTACHMENT',
    'LINK',
  ]),
}

const Channels = ({ sort, fetchPolicy }) => (
  <ExploreContents type="CHANNEL" sort={sort} fetchPolicy={fetchPolicy} />
)

Channels.propTypes = {
  sort: PropTypes.oneOf(['UPDATED_AT', 'RANDOM']).isRequired,
  fetchPolicy: PropTypes.oneOf(['cache-first', 'network-only']).isRequired,
}

class ExploreViews extends Component {
  static getDerivedStateFromProps(nextProps, prevState) {
    // Once the view changes switch into "network-only" mode
    if (nextProps.view !== prevState.renderedView) {
      return { fetchPolicy: 'network-only' }
    }
    return null
  }

  static propTypes = {
    sort: PropTypes.oneOf(['UPDATED_AT', 'RANDOM']).isRequired,
    block_filter: PropTypes.oneOf([
      'IMAGE',
      'EMBED',
      'TEXT',
      'ATTACHMENT',
      'LINK',
    ]),
  }

  static defaultProps = {
    block_filter: null,
  }

  state = {
    fetchPolicy: 'cache-first',
    // eslint-disable-next-line
    renderedView: this.props.view,
  }

  render() {
    const { fetchPolicy } = this.state
    const { view, sort, block_filter } = this.props

    switch (view) {
      case 'all':
        return <All sort={sort} fetchPolicy={fetchPolicy} />
      case 'channels':
        return <Channels sort={sort} fetchPolicy={fetchPolicy} />
      case 'blocks':
        return (
          <Blocks
            sort={sort}
            fetchPolicy={fetchPolicy}
            block_filter={block_filter}
          />
        )
      default:
        return null
    }
  }
}

export default ExploreViews
