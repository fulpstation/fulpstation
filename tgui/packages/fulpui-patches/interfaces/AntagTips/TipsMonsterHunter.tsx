import { useBackend } from 'tgui/backend';
import { Flex, Divider, Section } from '../../../tgui/components';

export const info = {
  body: () => <Tips />,
};

export const Tips = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Section fill>
      <Flex>
        <Flex.Item>
          You are a Monster Hunter, after deciding to leave retirement, you are
          now fighting Monsters one last time!
        </Flex.Item>
      </Flex>
      <Divider />
      <Flex>
        <Flex.Item>
          You are a Human, but learned the arts of Hunter-Fu, and Flow, allowing
          you to stand while in critical condition.
        </Flex.Item>
        <Divider vertical />
        <Flex.Item>
          Use your abilities to your advantage! Try to deduce who the Monsters
          are, what they are, and plan how to eliminate them.
        </Flex.Item>
      </Flex>
    </Section>
  );
};
