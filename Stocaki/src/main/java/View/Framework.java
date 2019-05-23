package View;

import org.jetbrains.annotations.Contract;
import org.jetbrains.annotations.NotNull;

import javax.imageio.ImageIO;
import javax.swing.*;
import javax.swing.table.TableCellRenderer;
import java.awt.*;
import java.awt.event.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

class Framework {

    enum VIEW {FUNCIONARIO_ADM, FUNCIONARIOS_ADM, MOVIMENTACOES_ADM, PRODUTO_ADM, PRODUTOS_ADM, REQUISICOES_ADM}

    static final Font TABLE_HEADER = new Font("Segoe UI", Font.BOLD , 24),
                      TABLE_BODY = new Font("Segoe UI", Font.PLAIN, 24);

    static final Color GREEN = new Color(72,180,80),
                       SOFTGREEN = new Color(116,206,119),
                       SELECTED = new Color(100,160,100);

    static final String ICONE_CAIXA = "imgs/iconeCaixa.png",
                        LOGIN_IMAGE = "imgs/loginImage.png",
                        SEARCH_IMAGE = "imgs/iconeBusca2.png",
                        MENU_BACKGROUND = "imgs/menuBackground.jpg";

    static final Dimension WINDOW_SIZE = new Dimension(1370, 795);

    static final boolean RESIZEABLE = true;

    private static JFrame currentFrame;
    private static JPanel currentPanel;

    static void setup(@NotNull final JFrame frame, @NotNull final JPanel panel) {
        final JFrame callerFrame = getCurrentFrame();
        final int extendedState = callerFrame.getExtendedState();
        final JPanel callerPanel = getCurrentPanel();
        final Dimension size = callerPanel.getSize();

        try {
            final BufferedImage image = ImageIO.read(new File(MENU_BACKGROUND));

            final JPanel imagePanel = new JPanel() {
                @Override
                protected void paintComponent(Graphics g) {
                    super.paintComponent(g);
                    g.drawImage(image, 0, 0, null);
                }
            };

            if (extendedState == JFrame.MAXIMIZED_BOTH || extendedState == JFrame.MAXIMIZED_HORIZ || extendedState == JFrame.MAXIMIZED_VERT) {
                imagePanel.setPreferredSize(WINDOW_SIZE);
                panel.setPreferredSize(WINDOW_SIZE);
                frame.setExtendedState(extendedState);
            } else {
                imagePanel.setPreferredSize(size);
                panel.setPreferredSize(size);
            }

            frame.setContentPane(imagePanel);
            frame.add(panel);

            setCurrentFrame(frame);
            setCurrentPanel(imagePanel);

            imagePanel.addComponentListener(new ComponentAdapter() {
                @Override
                public void componentResized(ComponentEvent e) {
                    panel.setPreferredSize(imagePanel.getSize());
                }
            });
        } catch (IOException e) {
            System.out.println("Imagem de fundo inválida!");

            if (extendedState == JFrame.MAXIMIZED_BOTH || extendedState == JFrame.MAXIMIZED_HORIZ || extendedState == JFrame.MAXIMIZED_VERT) {
                panel.setPreferredSize(WINDOW_SIZE);
                frame.setExtendedState(extendedState);
            } else {
                panel.setPreferredSize(size);
            }

            frame.setContentPane(panel);

            setCurrentFrame(frame);
            setCurrentPanel(panel);
        }
        frame.pack();
        frame.setLocationRelativeTo(callerFrame);
        frame.setResizable(RESIZEABLE);
        frame.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        frame.setVisible(true);
    }

    static void addToMenu(@NotNull final JPanel panel, final JFrame self, final VIEW target) {
        panel.addMouseListener(new MouseAdapter() {
            @Override
            public void mouseEntered(MouseEvent e) {
                panel.setBackground(Framework.SELECTED);
                panel.setCursor(Cursor.getPredefinedCursor(Cursor.HAND_CURSOR));
            }
            @Override
            public void mouseExited(MouseEvent e) {
                panel.setBackground(Framework.SOFTGREEN);
            }
            @Override
            public void mouseClicked(MouseEvent e) {
                navigate(self, target);
            }
        });
    }

    private static void navigate(JFrame self, @NotNull VIEW target) {
        switch (target) {
            case REQUISICOES_ADM:
                new RequisicoesAdm();
                self.dispose();
                break;
            default:
                System.out.println("Tela Inválida!");
                break;
        }
    }

    @Contract(pure = true)
    static JPanel getCurrentPanel() {
        return currentPanel;
    }

    static void setCurrentPanel(JPanel currentPanel) {
        Framework.currentPanel = currentPanel;
    }

    @Contract(pure = true)
    static JFrame getCurrentFrame() {
        return currentFrame;
    }

    static void setCurrentFrame(JFrame currentFrame) {
        Framework.currentFrame = currentFrame;
    }
}

//Buttons for tables

class ButtonRenderer extends JButton implements TableCellRenderer {

    ButtonRenderer() {
        setOpaque(true);
    }

    public Component getTableCellRendererComponent(JTable table, Object value,
                                                   boolean isSelected, boolean hasFocus, int row, int column) {
        if (isSelected) {
            setForeground(table.getSelectionForeground());
            setBackground(table.getSelectionBackground());
        } else {
            setForeground(table.getForeground());
            setBackground(UIManager.getColor("Button.background"));
        }
        setText((value == null) ? "" : value.toString());
        return this;
    }
}

class ButtonEditor extends DefaultCellEditor {
    private JButton button;

    private String label;

    private boolean isPushed;

    ButtonEditor(JCheckBox checkBox) {
        super(checkBox);
        button = new JButton();
        button.setOpaque(true);
        button.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                fireEditingStopped();
            }
        });
    }

    @Override
    public Component getTableCellEditorComponent(JTable table, Object value,
                                                 boolean isSelected, int row, int column) {
        if (isSelected) {
            button.setForeground(table.getSelectionForeground());
            button.setBackground(table.getSelectionBackground());
        } else {
            button.setForeground(table.getForeground());
            button.setBackground(table.getBackground());
        }
        label = (value == null) ? "" : value.toString();
        button.setText(label);
        isPushed = true;
        return button;
    }

    @Override
    public Object getCellEditorValue() {
        if (isPushed) {
            /*
            TODO
                Replace with optional actions based on the label icon?
            */
            JOptionPane.showMessageDialog(button, label + ": Ouch!");
        }
        isPushed = false;
        return label;
    }

    @Override
    public boolean stopCellEditing() {
        isPushed = false;
        return super.stopCellEditing();
    }

    @Override
    protected void fireEditingStopped() {
        super.fireEditingStopped();
    }
}