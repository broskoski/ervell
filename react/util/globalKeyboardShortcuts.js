import Mousetrap from 'mousetrap';

import { toggle as toggleDarkTheme } from 'react/components/UI/Layouts/BlankLayout/components/LegacyDarkTheme';

export const bind = () => {
  Mousetrap.bind('meta+shift+ctrl+i', toggleDarkTheme);
};

export const unbind = () => {
  Mousetrap.unbind([
    'meta+shift+ctrl+i',
  ]);
};

export default {
  bind,
  unbind,
};
