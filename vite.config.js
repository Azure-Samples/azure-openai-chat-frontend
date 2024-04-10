import { resolve } from 'node:path';
// eslint-disable-next-line n/no-unpublished-import
import { defineConfig, loadEnv } from 'vite';

process.env.VITE_SEARCH_API_URI = process.env.BACKEND_URI ?? 'http://localhost:3000';
process.env.VITE_IS_LIB = process.env.IS_LIB ?? 'false';
console.log(`Using search API base URL: "${process.env.VITE_SEARCH_API_URI}". This will only work if you started a local API in that port. Please set BACKEND_URI to change it.`);

const isLib = process.env.VITE_IS_LIB === 'true';
console.log(`Building as library: ${isLib}. You may deploy this version. If you want to build as library, set IS_LIB=true`);

const config = {
  entry: resolve(__dirname, 'src/index.ts'),
  name: 'chat-component',
  fileName: 'chat-component'
};

const distConfig = isLib ? config : undefined;

export default defineConfig({
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

