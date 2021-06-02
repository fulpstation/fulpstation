import {useBackend} from '../backend';
import {Button, LabeledList, Section} from '../components';
import {Window} from '../layouts';

export const SampleInterface = (props, context)=> {
	const {act,data} = useBackend(context);
	const{
		health,
		color,
	} = data;
	return (
		<Window resizable>
			<Window.Content scrollable>
				<Section title="Health status">
					<LabeledList.Item label = "Health">
						{health}
					</LabeledList.Item>
					<LabeledList.Item label = "Color">
						{color}
					</LabeledList.Item>
					<LabeledList.Item label = "Button">
						<Button
							content="Dispatch a 'test' action"
							onClick={()=>act('change_color',{
                color:"orange"
              })}/>
					</LabeledList.Item>
				</Section>
			</Window.Content>
		</Window>
	)
}
