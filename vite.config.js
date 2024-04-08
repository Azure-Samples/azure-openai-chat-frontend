import { resolve } from 'node:path';
// eslint-disable-next-line n/no-unpublished-import
import { defineConfig, loadEnv } from 'vite';  

export default ({ mode }) => {
  process.env = {...process.env, ...loadEnv(mode, process.cwd())};
  const isLib = process.env.VITE_IS_LIB === 'true';

  const config = {
    entry: resolve(__dirname, 'src/index.ts'),
    name: 'chat-component',
    fileName: 'chat-component'
  };

  const distConfig = isLib ? config : undefined;
  return defineConfig({
    build: {
      emptyOutDir: true,
      lib: distConfig,
    },
    server: {
      proxy: {
        '/ask': 'http://127.0.0.1:3000',
        '/chat': 'http://127.0.0.1:3000',
        '/content': 'http://127.0.0.1:3000',
      },
    },
  });
}
