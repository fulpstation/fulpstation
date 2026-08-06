import dateformat from 'dateformat';
import yaml from 'js-yaml';
import { Component, Fragment } from 'react';
import {
  Box,
  Button,
  Divider,
  Dropdown,
  Icon,
  Section,
  Stack,
  Table,
} from 'tgui-core/components';
import { classes } from 'tgui-core/react';

import { resolveAsset } from '../assets';
import { useBackend } from '../backend';
import { sendAct as act } from '../events/act';
import { ChangelogContent } from '../interfaces/Changelog';
import { Window } from '../layouts';

const icons = {
  add: { icon: 'check-circle', color: 'green' },
  admin: { icon: 'user-shield', color: 'purple' },
  balance: { icon: 'balance-scale-right', color: 'yellow' },
  bugfix: { icon: 'bug', color: 'green' },
  code_imp: { icon: 'code', color: 'green' },
  config: { icon: 'cogs', color: 'purple' },
  expansion: { icon: 'check-circle', color: 'green' },
  experiment: { icon: 'radiation', color: 'yellow' },
  image: { icon: 'image', color: 'green' },
  imageadd: { icon: 'tg-image-plus', color: 'green' },
  imagedel: { icon: 'tg-image-minus', color: 'red' },
  qol: { icon: 'hand-holding-heart', color: 'green' },
  refactor: { icon: 'tools', color: 'green' },
  rscadd: { icon: 'check-circle', color: 'green' },
  rscdel: { icon: 'times-circle', color: 'red' },
  server: { icon: 'server', color: 'purple' },
  sound: { icon: 'volume-high', color: 'green' },
  soundadd: { icon: 'tg-sound-plus', color: 'green' },
  sounddel: { icon: 'tg-sound-minus', color: 'red' },
  spellcheck: { icon: 'spell-check', color: 'green' },
  map: { icon: 'map', color: 'green' },
  tgs: { icon: 'toolbox', color: 'purple' },
  tweak: { icon: 'wrench', color: 'green' },
  unknown: { icon: 'info-circle', color: 'label' },
  wip: { icon: 'hammer', color: 'orange' },
};

type Change = Record<string, string>;
type AuthorChanges = Record<string, Change[]>;
type ChangelogYaml = Record<string, AuthorChanges>;

type ChangelogState = {
  loaded_text: ChangelogYaml | string;
  selectedDate: string;
  selectedIndex: number;
};

type ChangelogData = {
  fulp_dates: string[];
};

export class FulpChangelogContent extends Component<any, ChangelogState> {
  dateChoices: string[];

  constructor(props) {
    super(props);
    this.dateChoices = [];
    this.state = {
      loaded_text: 'Loading changelog data...',
      selectedDate: '',
      selectedIndex: 0,
    };
  }

  setData(loaded_text) {
    this.setState({ loaded_text });
  }

  setSelectedDate(selectedDate) {
    this.setState({ selectedDate });
  }

  setSelectedIndex(selectedIndex) {
    this.setState({ selectedIndex });
  }

  getData = (date, attemptNumber = 1) => {
    const maxAttempts = 6;

    if (attemptNumber > maxAttempts) {
      return this.setData(`Failed to load data after ${maxAttempts} attempts`);
    }

    act('get_month', { date });

    fetch(resolveAsset(`fulp_${date}.yml`)).then(async (changelogData) => {
      if (!changelogData.ok) {
        if (attemptNumber >= maxAttempts) {
          this.setData(`Failed to load after ${maxAttempts} attempts`);
          return;
        }

        const timeout = 50 + attemptNumber * 50;
        this.setData(`Loading changelog data${'.'.repeat(attemptNumber + 3)}`);
        setTimeout(() => {
          this.getData(date, attemptNumber + 1);
        }, timeout);
        return;
      }

      const result = await changelogData.text();
      this.setData(
        yaml.load(result, { schema: yaml.CORE_SCHEMA }) as ChangelogYaml,
      );
    });
  };

  componentDidMount() {
    const { data } = useBackend<ChangelogData>();
    const { fulp_dates = [] } = data;

    if (fulp_dates) {
      fulp_dates.forEach((date) => {
        this.dateChoices.push(dateformat(date, 'mmmm yyyy', true));
      });
      this.setSelectedDate(this.dateChoices[0]);
      this.getData(fulp_dates[0]);
    }
  }

  render() {
    const { data } = useBackend<ChangelogData>();
    const { fulp_dates = [] } = data;
    const { loaded_text, selectedIndex, selectedDate } = this
      .state as ChangelogState;
    const { dateChoices } = this;

    const dateDropdown = dateChoices.length > 0 && (
      <Stack>
        <Stack.Item>
          <Button
            className="Changelog__Button"
            disabled={selectedIndex === 0}
            icon={'chevron-left'}
            onClick={() => {
              const index = selectedIndex - 1;

              this.setData('Loading changelog data...');
              this.setSelectedIndex(index);
              this.setSelectedDate(dateChoices[index]);
              window.scrollTo(
                0,
                document.body.scrollHeight ||
                  document.documentElement.scrollHeight,
              );
              return this.getData(fulp_dates[index]);
            }}
          />
        </Stack.Item>
        <Stack.Item>
          <Dropdown
            autoScroll={false}
            options={dateChoices}
            onSelected={(value) => {
              const index = dateChoices.indexOf(value);

              this.setData('Loading changelog data...');
              this.setSelectedIndex(index);
              this.setSelectedDate(value);
              window.scrollTo(
                0,
                document.body.scrollHeight ||
                  document.documentElement.scrollHeight,
              );
              return this.getData(fulp_dates[index]);
            }}
            selected={selectedDate}
            width="150px"
          />
        </Stack.Item>
        <Stack.Item>
          <Button
            className="Changelog__Button"
            disabled={selectedIndex === dateChoices.length - 1}
            icon={'chevron-right'}
            onClick={() => {
              const index = selectedIndex + 1;

              this.setData('Loading changelog data...');
              this.setSelectedIndex(index);
              this.setSelectedDate(dateChoices[index]);
              window.scrollTo(
                0,
                document.body.scrollHeight ||
                  document.documentElement.scrollHeight,
              );
              return this.getData(fulp_dates[index]);
            }}
          />
        </Stack.Item>
      </Stack>
    );

    const header = (
      <Section>
        <h1>Fulpstation</h1>
        <p>
          <b>Please note: </b>
          this changelog would not be possible without the groundwork laid by
          /tg/station's contributors and so many others.
        </p>
        <p>
          Anything not visible here, including our license, is instead part of
          the Traditional Games 13 license.
        </p>
        <p>
          {'Recent GitHub contributors can be found '}
          <a href="https://github.com/fulpstation/fulpstation/pulse/monthly">
            here
          </a>
          .
        </p>
        <p>
          {
            'You can also find a link to the Fulpstation Discord at the front page of our wiki'
          }
          <a href="https://wiki.fulp.gg/"> here</a>.
        </p>
        {dateDropdown}
      </Section>
    );

    const footer = <Section>{dateDropdown}</Section>;

    const changes =
      typeof loaded_text === 'object' &&
      Object.keys(loaded_text).length > 0 &&
      Object.entries(loaded_text)
        .reverse()
        .map(([date, authors]) => (
          <Section key={date} title={dateformat(date, 'd mmmm yyyy', true)}>
            <Box ml={3}>
              {Object.entries(authors).map(([name, changes]) => (
                <Fragment key={name}>
                  <h4>{name} changed:</h4>
                  <Box ml={3}>
                    <Table>
                      {changes.map((change) => {
                        const changeType = Object.keys(change)[0];
                        return (
                          <Table.Row key={changeType + change[changeType]}>
                            <Table.Cell
                              className={classes([
                                'Changelog__Cell',
                                'Changelog__Cell--Icon',
                              ])}
                            >
                              <Icon
                                color={
                                  icons[changeType]
                                    ? icons[changeType].color
                                    : icons.unknown.color
                                }
                                name={
                                  icons[changeType]
                                    ? icons[changeType].icon
                                    : icons.unknown.icon
                                }
                              />
                            </Table.Cell>
                            <Table.Cell className="Changelog__Cell">
                              {change[changeType]}
                            </Table.Cell>
                          </Table.Row>
                        );
                      })}
                    </Table>
                  </Box>
                </Fragment>
              ))}
            </Box>
          </Section>
        ));

    return (
      <>
        {header}
        {changes}
        {typeof loaded_text === 'string' && <p>{loaded_text}</p>}
        {footer}
      </>
    );
  }
}

export const FulpChangelog = () => {
  return (
    <Window title="Changelog" width={1075} height={650}>
      <Window.Content scrollable>
        <Stack fill>
          <Stack.Item grow>
            <FulpChangelogContent />
          </Stack.Item>
          <Divider vertical />
          <Stack.Item grow>
            <ChangelogContent />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
