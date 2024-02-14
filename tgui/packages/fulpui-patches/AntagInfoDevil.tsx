import { BooleanLike } from 'common/react';

import { useBackend } from '../tgui/backend';
import { Box, Button, Image, Section, Stack } from '../tgui/components';
import { Window } from '../tgui/layouts';
import { Collapsible } from './../tgui/components/Collapsible';

type Info = {
  agent_amount: number;
  agents: AgentInfo[];
  souls_to_ascend: number;
  souls_collected: number;
};

type AgentInfo = {
  current_target: BooleanLike;
  agent_dead: BooleanLike;
  agent_body_ref: string;
  agent_name: string;
  agent_icon: string;
};

export const AntagInfoDevil = (props) => {
  return (
    <Window width={510} height={500} theme={'spookyconsole'}>
      <Window.Content scrollable>
        <Stack vertical>
          <Stack.Item>
            <IntroSection />
          </Stack.Item>
          <Stack.Item>
            <SoulsSection />
          </Stack.Item>
          <Stack.Item>
            <AgentsSection />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

export const IntroSection = (props) => {
  return (
    <Section>
      <Stack vertical>
        <Box fontSize="24px" mb={1}>
          You are the Devil!
        </Box>
        <Collapsible title="General Information">
          <Box>
            From the depths of hell you crawl, today you have assembled many
            people all of whom you rightfully own the soul to. Since merely
            killing people is boring, instead it is time for a game, a battle
            royale!
          </Box>
          <Box>
            All agents have to kill eachother and turn their corpses in to you
            to reap some minor rewards, you can use your <b>Collect Soul</b>{' '}
            ability to complete this process.
          </Box>
        </Collapsible>
        <Collapsible title="Avoiding Getting Caught">
          <Box>
            If you die, you will slowly heal until you revive yourself. If your
            body is destroyed you will return to hell, never to return! Work
            with your agents to avoid this if necessary.
          </Box>
          <Box>
            Your agents can be caught by the Codex Gigas by a Lawyer, Curator,
            or Head of Personnel. If this happens, you will immediately take
            away their equipment as punishment for their failure.
          </Box>
        </Collapsible>
      </Stack>
    </Section>
  );
};

export const AgentsSection = (props) => {
  const { act, data } = useBackend<Info>();
  const { agents = [] } = data;
  return (
    <Section title="Agents">
      <Stack vertical>
        <Box>
          The list of all agents currently in play, everyone has the person to
          the right as their target (the last person having the first one as
          their target). Clicking on a character will select them as the person
          you are performing spells on, allowing you to give agents advantages
          for any reason you see fit.
        </Box>
        <Stack.Item>
          {agents.map((individual_agent, number) => (
            <Button
              color={individual_agent.current_target ? 'bad' : 'black'}
              key={number}
              onClick={() =>
                act('set_target', {
                  agent_body_ref: individual_agent.agent_body_ref,
                })
              }
            >
              <Stack.Item grow>
                <Image
                  height="5rem"
                  src={`data:image/jpeg;base64,${individual_agent.agent_icon}`}
                  verticalAlign="middle"
                />
                {!!individual_agent.agent_dead && (
                  <Button tooltip="OUT FOR THE COUNT" icon="skull" />
                )}
                <Box>{individual_agent.agent_name}</Box>
              </Stack.Item>
            </Button>
          ))}
        </Stack.Item>
      </Stack>
    </Section>
  );
};

export const SoulsSection = (props) => {
  const { act, data } = useBackend<Info>();
  const { agent_amount, souls_to_ascend, souls_collected } = data;
  return (
    <Section>
      <Stack vertical>
        {agent_amount !== souls_to_ascend ? (
          <Box fontSize="14px" bold>
            There are not enough agents around for you to ascend. Make more
            using your Contracts spell.
          </Box>
        ) : (
          <Box fontSize="18px" bold>
            You are {souls_collected}/{souls_to_ascend} souls to Ascension.
          </Box>
        )}
      </Stack>
    </Section>
  );
};
