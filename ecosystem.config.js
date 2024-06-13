module.exports = {
  apps: [
    {
      name: "server",
      script: "venv/bin/python main.py",
      env: {
        HOST: "0.0.0.0",
        PORT: 80
      },
    },
  ],
};
