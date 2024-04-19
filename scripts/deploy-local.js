const { exec } = require("child_process");

const deploy = () => {
  console.log("Deploying contracts into localhost...");

  // Execute hardhat compile command
  exec(
    `npx hardhat compile && npx hardhat ignition deploy ignition/modules/deploy.ts --network localhost`,
    (error, stdout, stderr) => {
      if (error) {
        console.error(`Error: ${error.message}`);
        return;
      }
      if (stderr) {
        console.error(`stderr: ${stderr}`);
        return;
      }
      console.log(`Compilation and deployment success: ${stdout}`);
    }
  );
};

deploy();
