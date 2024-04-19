import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

export default buildModule("MelodyMintModule", (m) => {
  const MelodyMintContract = m.contract("MelodyMintContract");

  return { MelodyMintContract };
});
