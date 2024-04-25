import { classes } from 'common/react';

import { useBackend } from '../tgui/backend';
import { Box, Divider, Flex, Section, Stack } from '../tgui/components';
import { Window } from '../tgui/layouts';

type AntagTipInfo = {
  name: string;
  theme: string;
  antag_tips: string[];
};

export const AntagTips = (props) => {
  const { act, data } = useBackend<AntagTipInfo>();
  const { theme, name, antag_tips } = data;
  const nameToUpperCase = (str: string) =>
    str.replace(/^\w/, (c) => c.toUpperCase());

  return (
    <Window width={400} height={500} theme={theme}>
      <Window.Content scrollable>
        <Section>
          <Box bold inline p={2}>
            You are the {nameToUpperCase(name)}!
          </Box>
          <Box
            opacity={0.4}
            position="absolute"
            className={classes(['antagonists96x96', name, 'antagonist-icon'])}
          />
          <Divider />
          <Stack mb={1}>
            <Stack.Item grow>
              {(!antag_tips && 'None!') ||
                antag_tips.map((antag_tip) => (
                  <>
                    <Stack.Item key={antag_tip}>{antag_tip}</Stack.Item>
                    <Divider />
                  </>
                ))}
            </Stack.Item>
          </Stack>
          <Flex>
            <Flex.Item>
              Don&#39;t be afraid to ask <b>mentors</b> for help using the
              mentorhelp button.
            </Flex.Item>
          </Flex>
        </Section>
      </Window.Content>
    </Window>
  );
};
