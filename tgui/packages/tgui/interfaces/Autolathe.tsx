import { BooleanLike, classes } from 'common/react';
import { capitalize } from 'common/string';

import { useBackend } from '../backend';
import {
  Box,
  Button,
  Collapsible,
  Icon,
  LabeledList,
  ProgressBar,
  Section,
  Stack,
  Tooltip,
} from '../components';
import { Window } from '../layouts';
import { DesignBrowser } from './Fabrication/DesignBrowser';
import { MaterialCostSequence } from './Fabrication/MaterialCostSequence';
import { Design, MaterialMap } from './Fabrication/Types';
import { Material } from './Fabrication/Types';

type AutolatheDesign = Design & {
  customMaterials: BooleanLike;
};

type AutolatheData = {
  materials: Material[];
  materialtotal: number;
  materialsmax: number;
  MINERAL_MATERIAL_AMOUNT: number;
  designs: AutolatheDesign[];
  active: BooleanLike;
};

export const Autolathe = (props) => {
  const { data } = useBackend<AutolatheData>();
  const {
    materialtotal,
    materialsmax,
    materials,
    designs,
    active,
    MINERAL_MATERIAL_AMOUNT,
  } = data;

  const filteredMaterials = materials.filter((material) => material.amount > 0);

  const availableMaterials: MaterialMap = {};

  for (const material of filteredMaterials) {
    availableMaterials[material.name] = material.amount;
  }

  return (
    <Window title="Autolathe" width={670} height={600}>
      <Window.Content scrollable>
        <Stack vertical fill>
          <Stack.Item>
            <Section title="Total Materials">
              <LabeledList>
                <LabeledList.Item label="Total Materials">
                  <ProgressBar
                    value={materialtotal}
                    minValue={0}
                    maxValue={materialsmax}
                    ranges={{
                      good: [materialsmax * 0.85, materialsmax],
                      average: [materialsmax * 0.25, materialsmax * 0.85],
                      bad: [0, materialsmax * 0.25],
                    }}
                  >
                    {materialtotal / MINERAL_MATERIAL_AMOUNT +
                      '/' +
                      materialsmax / MINERAL_MATERIAL_AMOUNT +
                      ' sheets'}
                  </ProgressBar>
                </LabeledList.Item>
                <LabeledList.Item>
                  {filteredMaterials.length > 0 && (
                    <Collapsible title="Materials">
                      <LabeledList>
                        {filteredMaterials.map((material) => (
                          <LabeledList.Item
                            key={material.name}
                            label={capitalize(material.name)}
                          >
                            <ProgressBar
                              style={{
                                transform: 'scaleX(-1) scaleY(1)',
                              }}
                              value={materialsmax - material.amount}
                              maxValue={materialsmax}
                              backgroundColor={material.color}
                              color="black"
                            >
                              <div style={{ transform: 'scaleX(-1)' }}>
                                {material.amount / MINERAL_MATERIAL_AMOUNT +
                                  ' sheets'}
                              </div>
                            </ProgressBar>
                          </LabeledList.Item>
                        ))}
                      </LabeledList>
                    </Collapsible>
                  )}
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
          <Stack.Item grow>
            <DesignBrowser
              busy={!!active}
              designs={designs}
              availableMaterials={availableMaterials}
              buildRecipeElement={(
                design,
                availableMaterials,
                _onPrintDesign,
              ) => (
                <AutolatheRecipe
                  design={design}
                  MINERAL_MATERIAL_AMOUNT={MINERAL_MATERIAL_AMOUNT}
                  availableMaterials={availableMaterials}
                />
              )}
            />
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};

type PrintButtonProps = {
  design: Design;
  quantity: number;
  availableMaterials: MaterialMap;
  MINERAL_MATERIAL_AMOUNT: number;
  maxmult: number;
};

const PrintButton = (props: PrintButtonProps) => {
  const { act } = useBackend<AutolatheData>();
  const {
    design,
    quantity,
    availableMaterials,
    MINERAL_MATERIAL_AMOUNT,
    maxmult,
  } = props;

  const canPrint = maxmult >= quantity;
  return (
    <Tooltip
      content={
        <MaterialCostSequence
          design={design}
          amount={quantity}
          MINERAL_MATERIAL_AMOUNT={MINERAL_MATERIAL_AMOUNT}
          available={availableMaterials}
        />
      }
    >
      <div
        className={classes([
          'FabricatorRecipe__Button',
          !canPrint && 'FabricatorRecipe__Button--disabled',
        ])}
        color={'transparent'}
        onClick={() =>
          canPrint && act('make', { id: design.id, multiplier: quantity })
        }
      >
        &times;{quantity}
      </div>
    </Tooltip>
  );
};

type AutolatheRecipeProps = {
  design: AutolatheDesign;
  availableMaterials: MaterialMap;
  MINERAL_MATERIAL_AMOUNT: number;
};

const AutolatheRecipe = (props: AutolatheRecipeProps) => {
  const { act } = useBackend<AutolatheData>();
  const { design, availableMaterials, MINERAL_MATERIAL_AMOUNT } = props;

  let maxmult = 0;
  if (design.customMaterials) {
    const smallest_mat =
      Object.entries(availableMaterials).reduce(
        (accumulator: number, [material, amount]) => {
          return Math.min(accumulator, amount);
        },
        Infinity,
      ) || 0;

    if (smallest_mat > 0) {
      maxmult = Object.entries(design.cost).reduce(
        (accumulator: number, [material, required]) => {
          return Math.min(accumulator, smallest_mat / required);
        },
        Infinity,
      );
    } else {
      maxmult = 0;
    }
  } else {
    maxmult = Object.entries(design.cost).reduce(
      (accumulator: number, [material, required]) => {
        return Math.min(
          accumulator,
          (availableMaterials[material] || 0) / required,
        );
      },
      Infinity,
    );
  }
  maxmult = Math.min(Math.floor(maxmult), 50);
  const canPrint = maxmult > 0;

  return (
    <div className="FabricatorRecipe">
      <Tooltip content={design.desc} position="right">
        <div
          className={classes([
            'FabricatorRecipe__Button',
            'FabricatorRecipe__Button--icon',
            !canPrint && 'FabricatorRecipe__Button--disabled',
          ])}
        >
          <Icon name="question-circle" />
        </div>
      </Tooltip>
      <Tooltip
        content={
          <MaterialCostSequence
            design={design}
            amount={1}
            MINERAL_MATERIAL_AMOUNT={MINERAL_MATERIAL_AMOUNT}
            available={availableMaterials}
          />
        }
      >
        <div
          className={classes([
            'FabricatorRecipe__Title',
            !canPrint && 'FabricatorRecipe__Title--disabled',
          ])}
          onClick={() =>
            canPrint && act('make', { id: design.id, multiplier: 1 })
          }
        >
          <div className="FabricatorRecipe__Icon">
            <Box
              width={'32px'}
              height={'32px'}
              className={classes(['design32x32', design.icon])}
            />
          </div>
          <div className="FabricatorRecipe__Label">{design.name}</div>
        </div>
      </Tooltip>

      <PrintButton
        design={design}
        quantity={5}
        MINERAL_MATERIAL_AMOUNT={MINERAL_MATERIAL_AMOUNT}
        availableMaterials={availableMaterials}
        maxmult={maxmult}
      />

      <PrintButton
        design={design}
        quantity={10}
        MINERAL_MATERIAL_AMOUNT={MINERAL_MATERIAL_AMOUNT}
        availableMaterials={availableMaterials}
        maxmult={maxmult}
      />

      <div
        className={classes([
          'FabricatorRecipe__Button',
          !canPrint && 'FabricatorRecipe__Button--disabled',
        ])}
      >
        <Button.Input
          color="transparent"
          onCommit={(_e, value: string) =>
            act('make', {
              id: design.id,
              multiplier: value,
            })
          }
        >
          [Max: {maxmult}]
        </Button.Input>
      </div>
    </div>
  );
};
