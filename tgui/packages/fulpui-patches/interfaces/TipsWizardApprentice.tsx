import { useBackend } from 'tgui/backend';
import { Box, Flex, Divider, Section } from '../../tgui/components';
import { resolveAsset } from '../../tgui/assets';
import { Window } from '../../tgui/layouts';

type Name = {
  name: string;
};

export const TipsWizardApprentice = (props, context) => {
  const { act, data } = useBackend<Name>(context);
  const { name } = data;
  return (
    <Window width={400} height={410} theme="wizard">
      <Window.Content>
        <Section>
          <Flex>
            <Flex.Item>
              <Box bold inline p={2}>
                You are the {name}!
              </Box>
              <Box
                position="absolute"
                height="12rem"
                as="img"
                opacity={0.4}
                src={resolveAsset(`wizard.png`)}
              />
            </Flex.Item>
          </Flex>
          <Divider />
          <Flex>
            <Flex.Item>
              You are a wizard apprentice, summoned by your master.
            </Flex.Item>
          </Flex>
          <Divider />
          <Flex>
            <Flex.Item>
              <Box
                as="img"
                height="20px"
                src={resolveAsset(`spellbook.png`)}
              />
              Your primary objective is to help your master, depending on which spells they picked for you.
            </Flex.Item>
            <Divider vertical />
            <Flex.Item>
              <Box
                as="img"
                height="20px"
                src={resolveAsset(`scroll.png`)}
              />
              Use your <b>lesser scroll of teleportation</b> to get to the station.
            </Flex.Item>
          </Flex>
          <Divider />
          <Flex>
            <Flex.Item>
              There are 4 loadouts which your master has possibly picked for you:
            </Flex.Item>
          </Flex>
          <Divider />
          <Flex>
            <Flex.Item>
              <b>Destruction:</b>Contains the spells fireball and magic missile. Perfect for a hostile wizard, keep in mind that these can hit your master too.
            </Flex.Item>
            <Divider vertical />
            <Flex.Item>
              <b>Bluespace:</b>Contains the spells ethereal jaunt and teleport. Best used to sneak around for your own equipment.
            </Flex.Item>
            <Divider vertical />
          </Flex>
          <Divider />
          <Flex>
            <Flex.Item>
              <b>Healing:</b>Contains a healing staff, and the spells charge and forcewall. You can help as a support, able to heal your master&#39;s damage.
            </Flex.Item>
            <Divider vertical />
            <Flex.Item>
              <b>Robeless:</b>Contains the robeless spells knock and mind transfer. Effective for stealth and impersonating someone.
            </Flex.Item>
          </Flex>
        </Section>
      </Window.Content>
    </Window>
  );
};
