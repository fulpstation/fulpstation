import { BooleanLike } from 'common/react';
import { toTitleCase } from 'common/string';

import { useBackend } from '../backend';
import { Box, Button, Grid, NoticeBox, Section } from '../components';
import { Window } from '../layouts';

type Data = {
  shaking: BooleanLike;
  question: string;
  answers: Answer[];
};

type Answer = {
  answer: string;
  amount: number;
  selected: BooleanLike;
};

export const EightBallVote = (props) => {
  const { act, data } = useBackend<Data>();
  const { shaking } = data;
  return (
    <Window width={400} height={600}>
      <Window.Content>
        {(!shaking && (
          <NoticeBox>No question is currently being asked.</NoticeBox>
        )) || <EightBallVoteQuestion />}
      </Window.Content>
    </Window>
  );
};

const EightBallVoteQuestion = (props) => {
  const { act, data } = useBackend<Data>();
  const { question, answers = [] } = data;
  return (
    <Section>
      <Box bold textAlign="center" fontSize="16px" m={1}>
        &quot;{question}&quot;
      </Box>
      <Grid>
        {answers.map((answer) => (
          <Grid.Column key={answer.answer}>
            <Button
              fluid
              bold
              content={toTitleCase(answer.answer)}
              selected={answer.selected}
              fontSize="16px"
              lineHeight="24px"
              textAlign="center"
              mb={1}
              onClick={() =>
                act('vote', {
                  answer: answer.answer,
                })
              }
            />
            <Box bold textAlign="center" fontSize="30px">
              {answer.amount}
            </Box>
          </Grid.Column>
        ))}
      </Grid>
    </Section>
  );
};
