import React, {useState, useEffect} from 'react'
import {
    chakra, Button, List, ListItem, Heading, Flex, Input, Text, HStack, VStack, Box, CheckboxGroup, Checkbox,
} from '@chakra-ui/react'
import {CloseIcon} from '@chakra-ui/icons'
import {saveAs} from 'file-saver';


export const Home = () => {
    const [todos, setTodos] = useState([])
    const [text, setText] = useState('')
    const [sortingCheckedItems, setSortingChecks] = useState([false, false])
    const [todosToDisplay, setDisplay] = useState([])
    const [filterCheckedItems, setFilterChecks] = useState([false, false])
    const [nameFilterText, setNameFilter] = useState("")

    const changeCompletionHandle = (todo, completed) => {
        const todoToReplace = {
            id: todo.id, text: todo.text, completed: completed
        }
        let todosToChange = todos.map(td => todo.id === td.id ? todoToReplace : td);
        setTodos(todosToChange);
        setDisplay(todosToChange);
        saveTodos(todosToChange);
    }


    useEffect(() => {
        const localStorageTodos = JSON.parse(localStorage.getItem("todos")) || [];
        setTodos(localStorageTodos);
        setDisplay(localStorageTodos);
    }, []);

    const saveTodos = (tds) => {
        localStorage.setItem("todos", JSON.stringify(tds));
        setFilterChecks([false, false]);
        setSortingChecks([false, false]);
        setDisplay(tds);
    }

    const completionFilterHandler = (checks) => { //checks[0] - completed, checks[1] - not completed
        setFilterChecks(checks);
        updateDisplay(checks, sortingCheckedItems, nameFilterText);
    }

    const changeSortHandler = (checks) => {
        setSortingChecks(checks);
        updateDisplay(filterCheckedItems, checks, nameFilterText);
    }

    const nameFilterHandler = (text) => {
        setNameFilter(text);
        updateDisplay(filterCheckedItems, sortingCheckedItems, text);
    }

    const updateDisplay = (filterChecks, sortChecks, nameFilter) => {
        let cpy = [...todos]
        if (!filterChecks.every((elem) => elem === false)) {
            cpy = [...todos].filter((todo) => (todo.completed === filterChecks[0]));
        }
        if (sortChecks[0]) {
            cpy = cpy.sort((a, b) => (a.text).localeCompare(b.text));
        }
        if (sortChecks[1]) {
            cpy = cpy.sort((a, b) => (a.completed === b.completed ? 0 : a.completed > b.completed ? 1 : -1))
        }
        if (nameFilter !== '') {
            cpy = cpy.filter((todo) => todo.text.startsWith(nameFilter));
        }
        setDisplay(cpy);
    }
    const createTodoHandler = (text) => {
        let todo = {
            id: Date.now(), text: text, completed: false
        }
        let newTodos = [...todos, todo]
        setTodos(newTodos);
        setText("")
        saveTodos(newTodos);
    }

    const handleDownload = () => {
        const file = new Blob([JSON.stringify(todos)], {type: 'application/json'});
        saveAs(file, 'ToDoList.json');
    };

    const removeTodoHandler = (id) => {
        const newTodos = todos.filter((todo) => todo.id !== id);
        setTodos(newTodos);
        saveTodos(newTodos);
    }

    const fileUploadHandle = (file) => {
        const reader = new FileReader();
        reader.addEventListener("load", event => {
            console.log(event.target.result)
            try {
                let _ = JSON.parse(event.target.result);
                localStorage.setItem("todos", event.target.result);
                location.reload()
            } catch (err) {
                location.reload();
            }
        });
        reader.readAsText(file)
    }

    return (<Flex
        flexDirection="column"
        h="100vh"
        w="100vw"
        m="1rem"
        gap="1rem"
        alignItems="center"
    >
        <Heading textTransform="uppercase" fontSize={"6xl"} fontWeight={"extrabold"} bgClip={"text"}
                 bgGradient={"linear(to-r, blue.300, pink.400)"}>Todo List</Heading>
        <List
            h="60vh"
            w="70vw"
            display="flex"
            flexDirection="column"
            overflowY="scroll"
            border="2px solid black"
            borderRadius="sm"
            p="10px"
        >
            {todosToDisplay.map((todo) => (
                <ListItem
                    key={todo.id}
                    display="flex"
                    justifyContent="space-between"
                    alignItems="center"
                    borderBottom="1px solid gray"
                    py="8px"
                >
                    <Text>{todo.text}</Text>
                    <Box>
                        <Checkbox colorScheme={"green"} defaultChecked={todo.completed}
                                  onChange={(e) => changeCompletionHandle(todo, e.target.checked)}
                                  mr={7}>Выполнено</Checkbox>
                        <Button
                            onClick={() => removeTodoHandler(todo.id)}
                            background="red.500"
                            color="white"
                            float="right"
                            _hover={{
                                background: 'red.600',
                            }}
                        >
                            Удалить
                        </Button>
                    </Box>
                </ListItem>))}
        </List>
        <chakra.form
            onSubmit={(e) => {
                e.preventDefault()
                createTodoHandler(text)
            }}
            display="flex"
            flexDirection="column"
            alignItems="center"
            gap="20px"
        >
            <HStack>
                <VStack alignItems="left">
                    <Text>Фильтрация по выполнению:</Text>
                    <Checkbox colorScheme={"green"} isChecked={filterCheckedItems[0]}
                              onChange={(e) => completionFilterHandler([e.target.checked, false])}>Выполнено</Checkbox>
                    <Checkbox colorScheme={"red"} icon={<CloseIcon/>} isChecked={filterCheckedItems[1]}
                              onChange={(e) => completionFilterHandler([false, e.target.checked])}>Не
                        выполнено</Checkbox>
                </VStack>
                <VStack p={"10"}>
                    <Input
                        placeholder="Напишите задачу..."
                        maxLength={80}
                        value={text}
                        onChange={(e) => setText(e.target.value)}
                        w="300px"
                        h="32px"
                    />
                    <Button
                        isDisabled={!text.trim().length}
                        type="submit"
                        w="fit-content"
                        background="blue.500"
                        color="white"
                        _hover={{
                            background: 'blue.600',
                        }}
                    >
                        Добавить задачу
                    </Button>
                </VStack>
                <VStack p={"10"} alignItems={"left"}>
                    <Box>
                        Сортировка:
                    </Box>
                    <CheckboxGroup>
                        <Checkbox isChecked={sortingCheckedItems[0]}
                                  onChange={(e) => changeSortHandler([e.target.checked, false])}>По
                            алфавиту</Checkbox>
                        <Checkbox isChecked={sortingCheckedItems[1]}
                                  onChange={(e) => changeSortHandler([false, e.target.checked])}>По
                            статусу</Checkbox>
                    </CheckboxGroup>
                </VStack>
            </HStack>

            <HStack justifyContent="space-between">
                <VStack>
                    <Text>Фильтация по названию</Text>
                    <Input
                        placeholder="Начало названия..."
                        maxLength={80}
                        value={nameFilterText}
                        onChange={(e) => nameFilterHandler(e.target.value)}
                        w="300px"
                        h="32px"
                    />
                </VStack>
            </HStack>
        </chakra.form>
        <HStack p={30}>
            <Button onClick={() => handleDownload()}>Скачать файл</Button>
            <Input type={"file"} accept={".json"} onChange={(e) => fileUploadHandle(e.target.files[0])}></Input>
        </HStack>
    </Flex>)
}