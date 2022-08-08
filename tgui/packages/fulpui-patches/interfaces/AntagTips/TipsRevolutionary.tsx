import { Box, Flex, Divider, Section } from '../../../tgui/components';
import { resolveAsset } from '../../../tgui/assets';

export const render = () => {
  return <Tips />;
};

const Tips = () => {
  return (
    <Section>
      <Flex>
        <Flex.Item>
          You are a revolutionary tasked with eliminating the heads of staff.
          You can accomplish this either by exile or assassination.
        </Flex.Item>
      </Flex>
      <Divider />
      <Flex>
        <Flex.Item>
          <Box as="img" height="20px" src={resolveAsset(`headrevhud.png`)} />
          There are <b>Head Revolutionaries</b> who are the leaders of the
          revolution, and MUST stay alive (and on station) at ALL costs.
        </Flex.Item>
        <Divider vertical />
        <Flex.Item>
          <Box as="img" height="20px" src={resolveAsset(`flash.png`)} />
          Head Revolutionaries use <b>flashes</b> to convert people to the
          revolution, this doesn&#39;t work on people with mindshields or flash
          protection.
        </Flex.Item>
      </Flex>
      <Divider />
      <Flex>
        <Flex.Item>
          <Box as="img" height="20px" src={resolveAsset(`revhud.png`)} />
          People with this <b>icon</b> are your fellow revolutionaries, help
          them accomplish your objectives.
        </Flex.Item>
        <Divider vertical />
        <Flex.Item>
          <Box as="img" height="20px" src={resolveAsset(`implanter.png`)} />
          In the case of being <b>mindshielded</b> or being bashed in the head
          with blunt weapons, you&#39;ll get deconverted. Avoid THIS at all
          costs.
        </Flex.Item>
      </Flex>
    </Section>
  );
};
