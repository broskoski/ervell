import React from 'react';

import { wrapWithApolloProvider, initClientSideApolloClient } from 'react/apollo';
import mount from 'react/util/mount';
import unmount from 'react/util/unmount';

import ModalComponent from 'react/components/UI/Modal/Modal';

export default class Modal {
  ModalComponent = ModalComponent

  constructor(Component, props = {}, modalProps = {}) {
    this.Component = Component;
    this.props = props;
    this.modalProps = modalProps;
    this.el = document.createElement('div');
  }

  open = () => {
    document.body.appendChild(this.el);

    this.Provided = wrapWithApolloProvider(initClientSideApolloClient())(this.Component, {
      onClose: this.close,
      ...this.props,
    });

    mount(
      <this.ModalComponent onClose={this.close} fitContent={this.modalProps.fitContent}>
        {this.Provided}
      </this.ModalComponent>,
      this.el,
    );
  }

  close = () => {
    unmount(this.el);
    this.el.parentNode.removeChild(this.el);
  }
}
