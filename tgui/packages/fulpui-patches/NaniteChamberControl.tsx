import { BooleanLike } from 'common/react';

import { useBackend } from '../tgui/backend';
import {
  Box,
  Button,
  Collapsible,
  LabeledList,
  NoticeBox,
  NumberInput,
  Section,
  Table,
} from '../tgui/components';
import { Window } from '../tgui/layouts';

type Data = {
  status_msg: string;
  locked: BooleanLike;
  occupant_name: string;
  has_nanites: BooleanLike;
  nanite_volume: number;
  regen_rate: number;
  safety_threshold: number;
  cloud_id: number;
  scan_level: number;
  mob_programs: MobData[];
};

type MobData = {
  extra_settings: ExtraSettingsData[];
  rules: RulesData[];
  name: string;
  desc: string;
  activated: BooleanLike;
  use_rate: number;
  can_trigger: BooleanLike;
  trigger_cost: number;
  trigger_cooldown: number;
  timer_trigger_delay: number;
  timer_trigger: number;
  timer_restart: number;
  timer_shutdown: number;
  has_extra_settings: BooleanLike;
  activation_code: number;
  deactivation_code: number;
  kill_code: number;
  trigger_code: number;
  has_rules: BooleanLike;
};

type ExtraSettingsData = {
  name: string;
  value: string;
};

type RulesData = {
  display: string;
};

export const NaniteChamberControl = (props) => {
  return (
    <Window width={380} height={570}>
      <Window.Content scrollable>
        <NaniteChamberControlContent />
      </Window.Content>
    </Window>
  );
};

const NaniteChamberControlContent = (props) => {
  const { act, data } = useBackend<Data>();
  const {
    status_msg,
    locked,
    occupant_name,
    has_nanites,
    nanite_volume,
    regen_rate,
    safety_threshold,
    cloud_id,
    scan_level,
    mob_programs = [],
  } = data;

  if (status_msg) {
    return <NoticeBox textAlign="center">{status_msg}</NoticeBox>;
  }

  return (
    <Section
      title={'Chamber: ' + occupant_name}
      buttons={
        <Button
          icon={locked ? 'lock' : 'lock-open'}
          content={locked ? 'Locked' : 'Unlocked'}
          color={locked ? 'bad' : 'default'}
          onClick={() => act('toggle_lock')}
        />
      }
    >
      {!has_nanites ? (
        <>
          <Box bold color="bad" textAlign="center" fontSize="30px" mb={1}>
            No Nanites Detected
          </Box>
          <Button
            fluid
            bold
            icon="syringe"
            content=" Implant Nanites"
            color="green"
            textAlign="center"
            fontSize="30px"
            lineHeight="50px"
            onClick={() => act('nanite_injection')}
          />
        </>
      ) : (
        <>
          <Section
            title="Status"
            buttons={
              <Button
                icon="exclamation-triangle"
                content="Destroy Nanites"
                color="bad"
                onClick={() => act('remove_nanites')}
              />
            }
          >
            <Table>
              <Table.Cell>
                <LabeledList>
                  <LabeledList.Item label="Nanite Volume">
                    {nanite_volume}
                  </LabeledList.Item>
                  <LabeledList.Item label="Growth Rate">
                    {regen_rate}
                  </LabeledList.Item>
                </LabeledList>
              </Table.Cell>
              <Table.Cell>
                <LabeledList>
                  <LabeledList.Item label="Safety Threshold">
                    <NumberInput
                      value={safety_threshold}
                      minValue={0}
                      maxValue={500}
                      width="39px"
                      onChange={(e, value) =>
                        act('set_safety', {
                          value: value,
                        })
                      }
                    />
                  </LabeledList.Item>
                  <LabeledList.Item label="Cloud ID">
                    <NumberInput
                      value={cloud_id}
                      minValue={0}
                      maxValue={100}
                      step={1}
                      stepPixelSize={3}
                      width="39px"
                      onChange={(e, value) =>
                        act('set_cloud', {
                          value: value,
                        })
                      }
                    />
                  </LabeledList.Item>
                </LabeledList>
              </Table.Cell>
            </Table>
          </Section>
          <Section title="Programs">
            {mob_programs.map((program) => {
              const extra_settings = program.extra_settings || [];
              const rules = program.rules || [];
              return (
                <Collapsible key={program.name} title={program.name}>
                  <Section>
                    <Table>
                      <Table.Cell>{program.desc}</Table.Cell>
                      {scan_level >= 2 && (
                        <Table.Cell size={0.6}>
                          <LabeledList>
                            <LabeledList.Item label="Activation Status">
                              <Box color={program.activated ? 'good' : 'bad'}>
                                {program.activated ? 'Active' : 'Inactive'}
                              </Box>
                            </LabeledList.Item>
                            <LabeledList.Item label="Nanites Consumed">
                              {program.use_rate}/s
                            </LabeledList.Item>
                          </LabeledList>
                        </Table.Cell>
                      )}
                    </Table>
                    {scan_level >= 2 && (
                      <Table>
                        {!!program.can_trigger && (
                          <Table.Cell>
                            <Section title="Triggers">
                              <LabeledList>
                                <LabeledList.Item label="Trigger Cost">
                                  {program.trigger_cost}
                                </LabeledList.Item>
                                <LabeledList.Item label="Trigger Cooldown">
                                  {program.trigger_cooldown}
                                </LabeledList.Item>
                                {!!program.timer_trigger_delay && (
                                  <LabeledList.Item label="Trigger Delay">
                                    {program.timer_trigger_delay} s
                                  </LabeledList.Item>
                                )}
                                {!!program.timer_trigger && (
                                  <LabeledList.Item label="Trigger Repeat Timer">
                                    {program.timer_trigger} s
                                  </LabeledList.Item>
                                )}
                              </LabeledList>
                            </Section>
                          </Table.Cell>
                        )}
                        {!!(
                          program.timer_restart || program.timer_shutdown
                        ) && (
                          <Table.Cell>
                            <Section>
                              <LabeledList>
                                {/* I mean, bruh, this indentation level
                                    is ABSOLUTELY INSANE!!! */}
                                {program.timer_restart && (
                                  <LabeledList.Item label="Restart Timer">
                                    {program.timer_restart} s
                                  </LabeledList.Item>
                                )}
                                {program.timer_shutdown && (
                                  <LabeledList.Item label="Shutdown Timer">
                                    {program.timer_shutdown} s
                                  </LabeledList.Item>
                                )}
                              </LabeledList>
                            </Section>
                          </Table.Cell>
                        )}
                      </Table>
                    )}
                    {scan_level >= 3 && !!program.has_extra_settings && (
                      <Section title="Extra Settings">
                        <LabeledList>
                          {extra_settings.map((extra_setting) => (
                            <LabeledList.Item
                              key={extra_setting.name}
                              label={extra_setting.name}
                            >
                              {extra_setting.value}
                            </LabeledList.Item>
                          ))}
                        </LabeledList>
                      </Section>
                    )}
                    {scan_level >= 4 && (
                      <Table>
                        <Table.Cell>
                          <Section title="Codes">
                            <LabeledList>
                              {!!program.activation_code && (
                                <LabeledList.Item label="Activation">
                                  {program.activation_code}
                                </LabeledList.Item>
                              )}
                              {!!program.deactivation_code && (
                                <LabeledList.Item label="Deactivation">
                                  {program.deactivation_code}
                                </LabeledList.Item>
                              )}
                              {!!program.kill_code && (
                                <LabeledList.Item label="Kill">
                                  {program.kill_code}
                                </LabeledList.Item>
                              )}
                              {!!program.can_trigger &&
                                !!program.trigger_code && (
                                  <LabeledList.Item label="Trigger">
                                    {program.trigger_code}
                                  </LabeledList.Item>
                                )}
                            </LabeledList>
                          </Section>
                        </Table.Cell>
                        {program.has_rules && (
                          <Table.Cell>
                            <Section title="Rules">
                              {rules.map((rule) => (
                                <Box key={rule.display}>{rule.display}</Box>
                              ))}
                            </Section>
                          </Table.Cell>
                        )}
                      </Table>
                    )}
                  </Section>
                </Collapsible>
              );
            })}
          </Section>
        </>
      )}
    </Section>
  );
};
