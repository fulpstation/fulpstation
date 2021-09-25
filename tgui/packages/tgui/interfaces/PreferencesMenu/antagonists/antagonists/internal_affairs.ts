import { Antagonist, Category } from "../base";
import { TRAITOR_MECHANICAL_DESCRIPTION } from "./traitor";

const InternalAffairsAgent: Antagonist = {
  key: "internalaffairsagent",
  name: "Internal Affairs Agent",
  description: [
    "Sent by either Nanotrasen or the Syndicate, find and assassinate your target, but watch your back.",
    TRAITOR_MECHANICAL_DESCRIPTION,
  ],
  category: Category.Roundstart,
  priority: -1,
};

export default InternalAffairsAgent;
