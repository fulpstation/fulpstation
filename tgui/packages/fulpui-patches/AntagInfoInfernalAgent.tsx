import { BooleanLike } from 'common/react';

import { useBackend } from '../tgui/backend';
import { BlockQuote, Section, Stack } from '../tgui/components';
import {
  Objective,
  ObjectivePrintout,
} from '../tgui/interfaces/common/Objectives';
import { Window } from '../tgui/layouts';

const badstyle = {
  color: 'red',
  fontWeight: 'bold',
};

const goalstyle = {
  color: 'lightblue',
  fontWeight: 'bold',
};

type Info = {
  last_one_standing: BooleanLike;
  target_name: string;
  target_job: string;
  target_state: string;
  code: number;
  failsafe_code: number;
  uplink_unlock_info: number;
  objectives: Objective[];
};

const IntroductionSection = (props) => {
  return (
    <Section title="Intro">
      <Stack vertical>
        <Stack.Item>
          You have sold your soul to the Devil in exchange for an uplink. You
          must now collect his other debts to pay back yours.
        </Stack.Item>
        <Stack.Item>
          To collect a soul, kill your target and plant a calling card onto
          them, then turn their corpse in to the Devil. Avoid Security at any
          cost.
        </Stack.Item>
        <Stack.Item>
          Once turned in, you will be given a new target to hunt down. Be
          careful, as the Devil may have some similar contract with others as
          well.
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const TargetSection = (props) => {
  const { data } = useBackend<Info>();
  const {
    last_one_standing,
    target_name,
    target_job,
    target_state,
    objectives,
  } = data;
  if (last_one_standing) {
    return (
      <Section title="LAST ONE STANDING">
        <Stack fill vertical>
          <Stack.Item bold>
            <ObjectivePrintout objectives={objectives} />
          </Stack.Item>
        </Stack>
      </Section>
    );
  }
  return (
    <Section title="Target">
      <Stack fill>
        <Stack.Item bold>Current Target: {target_name}</Stack.Item>
      </Stack>
      <Stack fill>
        <Stack.Item>
          {target_name}&apos;s assigned job: {target_job}
        </Stack.Item>
      </Stack>
      <Stack fill>
        <Stack.Item>
          {target_name}&apos;s current state: {target_state}
        </Stack.Item>
      </Stack>
      <Stack>
        <Stack.Item>
          Use your tracking device to find their location and take them out.
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const UplinkSection = (props) => {
  const { data } = useBackend<Info>();
  const { uplink_unlock_info, code, failsafe_code } = data;
  return (
    <Section title="Uplink">
      <Stack fill>
        <>
          <Stack.Item bold>
            {code && <span style={goalstyle}>Code: {code}</span>}
            <br />
            {failsafe_code && (
              <span style={badstyle}>Failsafe: {failsafe_code}</span>
            )}
          </Stack.Item>
          <Stack.Divider />
          <Stack.Item mt="1%">
            <BlockQuote>{uplink_unlock_info}</BlockQuote>
          </Stack.Item>
        </>
      </Stack>
    </Section>
  );
};

export const AntagInfoInfernalAgent = (props) => {
  return (
    <Window width={500} height={400} theme={'malfunction'}>
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item>
            <IntroductionSection />
          </Stack.Item>
          <Stack.Item>
            <TargetSection />
          </Stack.Item>
          <Stack.Item>
            <UplinkSection />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
