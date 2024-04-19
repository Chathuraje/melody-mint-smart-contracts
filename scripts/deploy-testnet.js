const { spawn } = require("child_process");

const deploy = (network) => {
  console.log("deploying the smart contract...");

  // Execute hardhat compile and deployment command
  const deployProcess = spawn(
    "npx",
    [
      "hardhat",
      "compile",
      "&&",
      "npx",
      "hardhat",
      "ignition",
      "deploy",
      "ignition/modules/deploy.ts",
      "--network",
      network,
      "--verify",
    ],
    { shell: true }
  );

  let confirmationReceived = false;

  deployProcess.stdout.on("data", (data) => {
    console.log(data.toString());

    if (
      !confirmationReceived &&
      data.toString().includes("Confirm deploy to network")
    ) {
      confirmationReceived = true;
      deployProcess.stdin.write("y\n");
    }
  });

  deployProcess.stderr.on("data", (data) => {
    console.error(data.toString());
  });

  deployProcess.on("close", (code) => {
    console.log(`Compilation and deployment process exited with code ${code}`);
  });
};

const network = process.argv[2];

if (!network) {
  console.error("Please provide the network as an argument.");
  process.exit(1);
}

deploy(network);
