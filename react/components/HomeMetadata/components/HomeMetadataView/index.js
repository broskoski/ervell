import React, { Component } from 'react';
import PropTypes from 'prop-types';

import Pocket from 'react/components/UI/Pocket';
import CookieLinkUnlessCurrent from 'react/components/UI/CookieLinkUnlessCurrent';

export default class HomeMetadataView extends Component {
  static propTypes = {
    sort: PropTypes.oneOf(['updated_at', 'random']).isRequired,
    view: PropTypes.oneOf(['all', 'channels', 'blocks']).isRequired,
  }

  isCurrent = ({ to, currentRoute }) =>
    currentRoute.pathname === to.split('?')[0];

  isViewActive = view => () =>
    this.props.view === view;

  render() {
    const { sort } = this.props;

    return (
      <Pocket title="View">
        <CookieLinkUnlessCurrent
          to={`/explore?sort=${sort}`}
          isActive={this.isViewActive('all')}
          prefix="Explore"
          name="view"
          value="all"
        >
          All
        </CookieLinkUnlessCurrent>

        <CookieLinkUnlessCurrent
          to={`/explore/channels?sort=${sort}`}
          isActive={this.isViewActive('channels')}
          prefix="Explore"
          name="view"
          value="channels"
        >
          Channels
        </CookieLinkUnlessCurrent>

        <CookieLinkUnlessCurrent
          to={`/explore/blocks?sort=${sort}`}
          isActive={this.isViewActive('blocks')}
          prefix="Explore"
          name="view"
          value="blocks"
        >
          Blocks
        </CookieLinkUnlessCurrent>
      </Pocket>
    );
  }
}
