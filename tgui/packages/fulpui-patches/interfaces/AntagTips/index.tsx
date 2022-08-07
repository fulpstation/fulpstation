import { useBackend } from 'tgui/backend';
import { classes } from 'common/react';
import { Box, Flex, Stack, Divider, Section } from '../../../tgui/components';
import { Window } from '../../../tgui/layouts';
const requireTipsPage = require.context('../AntagTips', true, /.tsx$/, "sync");

type AntagTipInfo = {
  tip_ui_name: string;
  name: string;
  theme: string;
};


export const AntagTips = (props, context) => {
  const { act, data } = useBackend<AntagTipInfo>(context);
  const { tip_ui_name, theme, name } = data;
  const nameToUpperCase = (str: string) =>
    str.replace(/^\w/, (c) => c.toUpperCase());

  return (
    <Window width={400} height={480} theme={theme}>
      <Window.Content>
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
              omg hiiii
            </Stack.Item>
          </Stack>
          <Flex>
            <Flex.Item>
              Don&#39;t be afraid to ask <b>mentors</b> for help using the mentorhelp button.
            </Flex.Item>
          </Flex>
        </Section>
      </Window.Content>
    </Window>
  );
};
