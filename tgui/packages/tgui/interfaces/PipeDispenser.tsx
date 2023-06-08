import { BooleanLike } from 'common/react';
import { useBackend, useLocalState } from '../backend';
import { Button, LabeledList, Section, Stack, Tabs } from '../components';
import { Window } from '../layouts';
import { ICON_BY_CATEGORY_NAME, ColorItem, LayerSelect, SmartPipeBlockSection } from './RapidPipeDispenser';

type Data = {
  // Dynamic
  category: number;
  piping_layer: number;
  categories: Category[];
  selected_color: string;
  init_directions: Directions;
  // Static
  paint_colors: Colors;
};

type Directions = {
  north: BooleanLike;
  south: BooleanLike;
  east: BooleanLike;
  west: BooleanLike;
};

type Colors = {
  green: string;
  blue: string;
  red: string;
  orange: string;
  cyan: string;
  dark: string;
  yellow: string;
  brown: string;
  pink: string;
  purple: string;
  violet: string;
  omni: string;
};

type Category = {
  cat_name: string;
  recipes: Recipe[];
};

type Recipe = {
  pipe_name: string;
  pipe_index: number;
  all_layers: BooleanLike;
  dir: number;
};

const PipeTypeSection = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { categories = [] } = data;
  const [categoryName, setCategoryName] = useLocalState(
    context,
    'categoryName',
    categories[0].cat_name
  );
  const shownCategory =
    categories.find((category) => category.cat_name === categoryName) ||
    categories[0];
  return (
    <Section fill scrollable>
      <Tabs>
        {categories.map((category, i) => (
          <Tabs.Tab
            fluid
            key={category.cat_name}
            icon={ICON_BY_CATEGORY_NAME[category.cat_name]}
            selected={category.cat_name === shownCategory.cat_name}
            onClick={() => setCategoryName(category.cat_name)}>
            {category.cat_name}
          </Tabs.Tab>
        ))}
      </Tabs>
      {shownCategory?.recipes.map((recipe) => (
        <Button
          key={recipe.pipe_index}
          fluid
          ellipsis
          content={recipe.pipe_name}
          title={recipe.pipe_name}
          onClick={() =>
            act('pipe_type', {
              pipe_type: recipe.pipe_index,
              pipe_dir: recipe.dir,
              category: shownCategory.cat_name,
            })
          }
        />
      ))}
    </Section>
  );
};

export const PipeDispenser = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  const { category: rootCategoryIndex } = data;
  return (
    <Window width={530} height={530}>
      <Window.Content>
        <Stack fill vertical>
          {rootCategoryIndex === 0 && (
            <Stack.Item>
              <Stack fill>
                <Stack.Item grow>
                  <Section>
                    <LabeledList>
                      <ColorItem />
                      <LayerSelect />
                    </LabeledList>
                  </Section>
                </Stack.Item>
                <Stack.Item width="90px">
                  <SmartPipeBlockSection />
                </Stack.Item>
              </Stack>
            </Stack.Item>
          )}
          <Stack.Item grow>
            <PipeTypeSection />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
