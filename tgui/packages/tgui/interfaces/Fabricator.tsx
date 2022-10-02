import { useBackend, useSharedState } from '../backend';
import { Stack, Section, Button, Icon, Dimmer } from '../components';
import { Window } from '../layouts';
import { Material, MaterialAmount, MaterialFormatting, MATERIAL_KEYS } from './common/Materials';
import { sortBy } from 'common/collections';
import { MineralAccessBar } from './Fabrication/MineralAccessBar';
import { SearchBar } from './Fabrication/SearchBar';
import { DesignCategoryTabs } from './Fabrication/DesignCategoryTabs';
import { FabricatorData, Design, MaterialMap } from './Fabrication/Types';

/**
 * A dummy category that, when selected, renders ALL recipes to the UI.
 */
const ALL_CATEGORY = '__ALL';

export const Fabricator = (props, context) => {
  const { act, data } = useBackend<FabricatorData>(context);
  const { fab_name, on_hold, designs, busy } = data;

  const [selectedCategory, setSelectedCategory] = useSharedState(
    context,
    'selected_category',
    ALL_CATEGORY
  );
  const [searchText, setSearchText] = useSharedState(
    context,
    'search_text',
    ''
  );

  // Sort the designs by name.
  const sortedDesigns = sortBy((design: Design) => design.name)(
    Object.values(designs)
  );

  // Reduce the material count array to a map of actually available materials.
  const availableMaterials: MaterialMap = {};

  for (const material of data.materials) {
    availableMaterials[material.name] = material.amount;
  }

  return (
    <Window title={fab_name} width={670} height={600}>
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item grow>
            <Stack fill>
              <Stack.Item width={'200px'}>
                <DesignCategoryTabs
                  currentCategory={selectedCategory}
                  onCategorySelected={(category) => {
                    setSelectedCategory(category);
                    setSearchText('');
                  }}
                  designs={sortedDesigns}
                />
              </Stack.Item>
              <Stack.Item grow>
                <Section
                  title={
                    selectedCategory === ALL_CATEGORY
                      ? 'All Designs'
                      : selectedCategory
                  }
                  fill>
                  <Stack vertical fill>
                    <Stack.Item>
                      <Section>
                        <SearchBar
                          searchText={searchText}
                          onSearchTextChanged={setSearchText}
                          hint={'Search this category...'}
                        />
                      </Section>
                    </Stack.Item>
                    <Stack.Item grow>
                      <Section fill style={{ 'overflow': 'auto' }}>
                        {sortedDesigns
                          .filter(
                            (design) =>
                              selectedCategory === ALL_CATEGORY ||
                              design.categories?.indexOf(selectedCategory) !==
                                -1
                          )
                          .filter((design) =>
                            design.name
                              .toLowerCase()
                              .includes(searchText.toLowerCase())
                          )
                          .map((design) => (
                            <Recipe
                              key={design.name}
                              design={design}
                              available={availableMaterials}
                            />
                          ))}
                      </Section>
                      {!!busy && (
                        <Dimmer
                          style={{
                            'font-size': '2em',
                            'text-align': 'center',
                          }}>
                          <Icon name="cog" spin />
                          {' Building items...'}
                        </Dimmer>
                      )}
                    </Stack.Item>
                  </Stack>
                </Section>
                {!!on_hold && (
                  <Dimmer
                    style={{ 'font-size': '2em', 'text-align': 'center' }}>
                    Mineral access is on hold, please contact the quartermaster.
                  </Dimmer>
                )}
              </Stack.Item>
            </Stack>
          </Stack.Item>
          <Stack.Item>
            <Section>
              <MineralAccessBar
                availableMaterials={sortBy((a: Material) => a.name)(
                  data.materials ?? []
                )}
                onEjectRequested={(material, amount) =>
                  act('remove_mat', { ref: material.ref, amount })
                }
              />
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

type MaterialCostProps = {
  design: Design;
  amount: number;
  available: MaterialMap;
};

const MaterialCost = (props: MaterialCostProps, context) => {
  const { design, amount, available } = props;

  return (
    <Stack wrap justify="space-around">
      {Object.entries(design.cost).map(([material, cost]) => (
        <Stack.Item key={material}>
          <MaterialAmount
            name={material as keyof typeof MATERIAL_KEYS}
            amount={cost * amount}
            formatting={MaterialFormatting.SIUnits}
            color={
              cost * amount > available[material]
                ? 'bad'
                : cost * amount * 2 > available[material]
                  ? 'average'
                  : 'normal'
            }
          />
        </Stack.Item>
      ))}
    </Stack>
  );
};

type PrintButtonProps = {
  design: Design;
  quantity: number;
  available: MaterialMap;
};

const PrintButton = (props: PrintButtonProps, context) => {
  const { act, data } = useBackend<FabricatorData>(context);
  const { design, quantity, available } = props;

  const canPrint = !Object.entries(design.cost).some(
    ([material, amount]) =>
      !available[material] || amount * quantity > (available[material] ?? 0)
  );

  return (
    <Button
      className={`Fabricator__PrintAmount ${
        !canPrint ? 'Fabricator__PrintAmount--disabled' : ''
      }`}
      tooltip={
        <MaterialCost design={design} amount={quantity} available={available} />
      }
      color={'transparent'}
      onClick={() => act('build', { ref: design.id, amount: quantity })}>
      &times;{quantity}
    </Button>
  );
};

const Recipe = (props: { design: Design; available: MaterialMap }, context) => {
  const { act, data } = useBackend<FabricatorData>(context);
  const { design, available } = props;

  const canPrint = !Object.entries(design.cost).some(
    ([material, amount]) =>
      !available[material] || amount > (available[material] ?? 0)
  );

  return (
    <div class="Fabricator__Recipe">
      <Stack justify="space-between" align="stretch">
        <Stack.Item>
          <Button
            icon="question-circle"
            color="transparent"
            tooltip={design.desc}
            tooltipPosition="left"
          />
        </Stack.Item>
        <Stack.Item grow>
          <Button
            color={'transparent'}
            className={`Fabricator__Button ${
              !canPrint ? 'Fabricator__Button--disabled' : ''
            }`}
            fluid
            tooltip={
              <MaterialCost design={design} amount={1} available={available} />
            }
            onClick={() => act('build', { ref: design.id, amount: 1 })}>
            {design.name}
          </Button>
        </Stack.Item>
        <Stack.Item>
          <PrintButton design={design} quantity={5} available={available} />
        </Stack.Item>
        <Stack.Item>
          <PrintButton design={design} quantity={10} available={available} />
        </Stack.Item>
      </Stack>
    </div>
  );
};
