import { useBackend, useLocalState } from '../backend';
import { NoticeBox, Section, Tabs, Input, Button, NumberInput, Stack, Collapsible } from '../components';
import { Window } from '../layouts';

type PthData = {
  db_connected: boolean;
  cached_ckeys: string[];
  ticket_cache: TicketData[];
  target_ckey?: string;
};

type TicketData = {
  ticket_number: number;
  round_id: number;
  ticket_log: TicketLogData[];
};

type TicketLogData = {
  timestamp: string;
  origin_ckey: string;
  target_ckey: string;
  action: string;
  message: string;
};

enum Pages {
  Cache = 1,
  TicketHistory = 2,
}

export const PlayerTicketHistory = (props: any, context: any) => {
  const { act, data } = useBackend<PthData>(context);

  const [page, setPage] = useLocalState(
    context,
    'page',
    data.target_ckey ? Pages.TicketHistory : Pages.Cache
  );

  const [cacheInput, setCacheInput] = useLocalState(context, 'cacheInput', '');
  const [cacheCount, setCacheCount] = useLocalState(context, 'cacheCount', 5);

  if (!data.db_connected) {
    return (
      <Window title="Player Ticket History">
        <Window.Content>
          <NoticeBox>The database is not connected.</NoticeBox>
        </Window.Content>
      </Window>
    );
  }

  return (
    <Window
      title={`Player Ticket History${
        data.target_ckey ? ` - ${data.target_ckey}` : ''
      }`}>
      <Window.Content>
        <Tabs>
          <Tabs.Tab
            key={Pages.Cache}
            selected={page === Pages.Cache}
            onClick={() => setPage(Pages.Cache)}>
            Cache
          </Tabs.Tab>
          <Tabs.Tab
            key={Pages.TicketHistory}
            selected={page === Pages.TicketHistory}
            onClick={() => setPage(Pages.TicketHistory)}>
            Ticket History
          </Tabs.Tab>
        </Tabs>
        {page === Pages.TicketHistory && <TicketHistory />}
        {page === Pages.Cache && (
          <Cache
            cacheInput={cacheInput}
            setCacheInput={setCacheInput}
            cacheCount={cacheCount}
            setCacheCount={setCacheCount}
          />
        )}
      </Window.Content>
    </Window>
  );
};

const TicketHistory = (props: any, context: any) => {
  const { act, data } = useBackend<PthData>(context);

  if (data.ticket_cache === undefined) {
    return (
      <Section>
        <NoticeBox>No player selected.</NoticeBox>
      </Section>
    );
  }

  const [activeTicket, setActiveTicket] = useLocalState<TicketData | undefined>(
    context,
    'ticket',
    undefined
  );

  // sory by round then ticket number, descending
  data.ticket_cache.sort((b, a) => {
    if (a.round_id === b.round_id) {
      return a.ticket_number - b.ticket_number;
    }
    return a.round_id - b.round_id;
  });

  return (
    <Section>
      Tickets in order of most recent to oldest:
      <hr />
      <Section scrollableHorizontal>
        <Stack>
          {data.ticket_cache.map((ticket, index) => (
            <Stack.Item key={index}>
              <Button
                icon="ticket"
                selected={
                  activeTicket !== undefined &&
                  activeTicket.round_id === ticket.round_id &&
                  activeTicket.ticket_number === ticket.ticket_number
                }
                onClick={() => {
                  setActiveTicket(ticket);
                }}>
                {`${ticket.round_id} #${ticket.ticket_number}`}
              </Button>
            </Stack.Item>
          ))}
        </Stack>
      </Section>
      <hr />
      {activeTicket === undefined ? (
        <NoticeBox>No ticket selected.</NoticeBox>
      ) : (
        <TicketView ticket={activeTicket} />
      )}
    </Section>
  );
};

type CacheProps = {
  cacheInput: string;
  setCacheInput: (value: string) => void;
  cacheCount: number;
  setCacheCount: (value: number) => void;
};

const Cache = (props: CacheProps, context: any) => {
  const { act, data } = useBackend<PthData>(context);

  return (
    <Section>
      <div>
        Query and cache:&nbsp;
        <Input
          value={props.cacheInput}
          onChange={(_: any, value: string) =>
            props.setCacheInput(value.toLowerCase())
          }
        />
        <NumberInput
          value={props.cacheCount}
          minValue={1}
          maxValue={20}
          onChange={(_: any, value: number) => props.setCacheCount(value)}
        />
        <Button
          icon="search"
          disabled={!props.cacheInput}
          onClick={() => {
            act('cache-user', {
              target: props.cacheInput,
              amount: props.cacheCount,
            });
          }}
        />
      </div>
      <div>
        {data.cached_ckeys.map((ckey) => (
          <Button
            key={ckey}
            icon="user"
            onClick={() => {
              act('select-user', { target: ckey });
            }}>
            {ckey}
          </Button>
        ))}
      </div>
    </Section>
  );
};

type TicketViewProps = {
  ticket: TicketData;
};

const TicketView = (props: TicketViewProps, context: any) => {
  const { act, data } = useBackend<PthData>(context);
  const [forceExpand, setForceExpand] = useLocalState(
    context,
    'forceExpand',
    false
  );

  // sort by timestamp
  props.ticket.ticket_log.sort((a, b) => {
    return a.timestamp.localeCompare(b.timestamp);
  });

  return (
    <Section
      buttons={
        <Button
          icon={forceExpand ? 'compress' : 'expand'}
          onClick={() => setForceExpand(!forceExpand)}
        />
      }>
      {props.ticket.ticket_log.map((log, index) => (
        <Collapsible
          tooltip={log.timestamp}
          open={forceExpand}
          key={`${props.ticket.round_id}-${props.ticket.ticket_number}-${index}`}
          title={`${log.action} - ${log.origin_ckey}${
            log.target_ckey ? ` -> ${log.target_ckey}` : ''
          }`}>
          {log.message}
        </Collapsible>
      ))}
    </Section>
  );
};
