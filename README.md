## Azure OpenAI Chat Frontend

This folder contains a Lit implementation, consisting of multiple LitElements that can be used to interact with the Azure OpenAI API.

It is a classic chat UI that can be used to send messages to the API and receive responses.

## Technical stack

The following technologies are part of the frontend application:

- [Lit](https://lit.dev) and LitElement
- [Web Components](https://developer.mozilla.org/en-US/docs/Web/Web_Components)
- [Vite](https://vitejs.dev/guide/) and [Rollup](https://rollupjs.org/introduction/) for local development, bundling and serving
- [TypeScript](https://www.typescriptlang.org/)
- [ESLint](https://eslint.org/) and [Prettier](https://prettier.io/) for code linting and formatting

## Configuration

The frontend application is configured using a global configuration file. You can enable or disable the default prompts, and configure the default prompt texts, the API endpoint and other settings.

All texts and labels are configurable to match your use case. To customize the texts, please edit the [global config](./src/config/globalConfig.js) file.

## Running the application

To run the application locally, you must install [Node.js LTS](https://nodejs.org) and make sure you can run `npm` commands from your terminal.

Then you can proceed by following these steps:

- To install all npm dependencies, please run `npm install`. This is a npm workspace, so all dependencies will be installed in the root folder.
- To start the local development server, open a new terminal and run `npm run start`. This will start the local development server on port 8000.
- To build the application, open a new terminal and run `npm run build`. This will generate a production build in the `dist` folder.

> [IMPORTANT]
> For the application to be functional, you will need to connect it to a locally running or remotely [deployed backend service](#deploying-the-app-to-azure-static-web-apps), and make sure that the data attribute `data-api-url` is pointing to the correct endpoint.

## Connecting to a deployed backend

The Search API service implements the [HTTP protocol for AI chat apps](https://github.com/Azure-Samples/ai-chat-app-protocol). It can be used with any backend service that implements the same protocol.

| Recommended backend repos | Development environment | 
| -- | -- | 
|[Node.js](https://github.com/Azure-Samples/azure-search-openai-javascript)|[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/Azure-Samples/azure-search-openai-javascript)|
|[Python](https://github.com/Azure-Samples/azure-search-openai-demo)|[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/Azure-Samples/azure-search-openai-demo)|

To connect to a backend, follow these steps:

1. Deploy the backend services as explained in their respective repository readme files, for example following these [steps to deploy the backend](https://github.com/Azure-Samples/azure-search-openai-javascript#deploying-from-scratch).
2. Once the backend service is fully deployed, get the backend URL with `azd env get-values | grep BACKEND_URI`.
3. Deploy the frontend application to Azure as [explained here](#deploying-the-app-to-azure-static-web-apps) or start it locally or in codespaces.
4. Set the backend URL in this repo, running `azd env set BACKEND_URI <your_backend_url>` that you got in step 2.
5. Depending on whether you want to use the deployed frontend app or the local frontend app:

- If you want to use the deployed frontend app, run `azd up` to redeploy.
- If you want to use the local frontend app on your machine or in Codespaces, run:

  ```sh
  # Export the environment variable.
  # The syntax may be different depending on your shell or if you're using Windows.
  export BACKEND_URI=<your_backend_url>

  # Start the app
  npm start
  ```

> [NOTE]
> You may need to enable CORS in your backend service, by running `azd env set ALLOWED_ORIGIN <your_frontend_url>`. 

Get the frontend URL, following this table:

| Environment | URL                                                     |
| ----------- | ------------------------------------------------------- |
| Local       | http://localhost:8000                                   |
| Production  | `azd env get-values \| grep FRONTEND_URI`               |
| Codespace   | `https://<your_codespace_base_url>-8000.app.github.dev` |

## Using this module as a library

If you want to use the module as a library as it is used in [the JavaScript sample](https://github.com/Azure-Samples/azure-search-openai-javascript), set the environment variable `IS_LIB` to true, running `azd env set IS_LIB true`.

## Deploying the app to Azure Static Web Apps

To deploy this application code to [Azure Static Web Apps](https://docs.microsoft.com/azure/static-web-apps/overview) you can use [Azure Static Web Apps CLI](https://learn.microsoft.com/azure/static-web-apps/static-web-apps-cli-deploy) or using the [Azure Developer CLI](https://learn.microsoft.com/azure/developer/azure-developer-cli/overview), by running `azd up` and following the instruction in the terminal.

